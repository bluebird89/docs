#!/bin/bash
# ----------------------------------------------------------------------
# mikes handy rotating-filesystem-snapshot utility
# ----------------------------------------------------------------------
# RCS info: $Id: make_snapshot.sh,v 1.6 2002/04/06 04:20:00 mrubel Exp $
# ----------------------------------------------------------------------
# this needs to be a lot more general, but the basic idea is it makes
# rotating backup-snapshots of /home whenever called
# ----------------------------------------------------------------------

# ------------- system commands used by this script --------------------
ID='/usr/bin/id';
ECHO='/bin/echo';

MOUNT='/bin/mount';
RM='/bin/rm';
MV='/bin/mv';
CP='/bin/cp';
TOUCH='/usr/bin/touch';

RSYNC='/usr/bin/rsync';


# ------------- file locations -----------------------------------------

MOUNT_DEVICE=/dev/hdb1;
SNAPSHOT_RW=/root/snapshots;
EXCLUDES=/etc/snapshot_exclude;


# ------------- backup configuration

BACKUP_DIRS="/etc /home"
NUM_OF_SNAPSHOTS=3
BACKUP_INTERVAL=hourly


# ------------- the script itself --------------------------------------

# make sure we're running as root
if (( `$ID -u` != 0 )); then { $ECHO "Sorry, must be root.  Exiting..."; exit; } fi

echo "Starting snapshot on "`date`

# attempt to remount the RW mount point as RW; else abort
$MOUNT -o remount,rw $MOUNT_DEVICE $SNAPSHOT_RW ;
if (( $? )); then
{
	$ECHO "snapshot: could not remount $SNAPSHOT_RW readwrite";
	exit;
}
fi;

# rotating snapshots
for BACKUP_DIR in $BACKUP_DIRS
do

  NUM=$NUM_OF_SNAPSHOTS

  # step 1: delete the oldest snapshot, if it exists:
  if [ -d ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.$NUM ] ; then			\
    $RM -rf ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.$NUM ;				\
  fi ;
  
  NUM=$(($NUM-1))
  
  # step 2: shift the middle snapshots(s) back by one, if they exist
  while [[ $NUM -ge 1 ]]
  do
    if [ -d ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.$NUM ] ; then			\
      $MV ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.$NUM ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.$(($NUM+1)) ;	\
    fi;
    NUM=$(($NUM-1))
  done
  
  # step 3: make a hard-link-only (except for dirs) copy of the latest snapshot,
  # if that exists
  if [ -d ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.0 ] ; then			\
  $CP -al ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.0 ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.1 ;	\
  fi;
  
  # step 4: rsync from the system into the latest snapshot (notice that
  # rsync behaves like cp --remove-destination by default, so the destination
  # is unlinked first.  If it were not so, this would copy over the other
  # snapshot(s) too!
  $RSYNC								\
          -va --delete --delete-excluded				\
          --exclude-from="$EXCLUDES"				\
          ${BACKUP_DIR}/ ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.0 ;
  
  # step 5: update the mtime of ${BACKUP_INTERVAL}.0 to reflect the snapshot time
  $TOUCH ${SNAPSHOT_RW}${BACKUP_DIR}/${BACKUP_INTERVAL}.0 ;

done

# now remount the RW snapshot mountpoint as readonly

$MOUNT -o remount,ro $MOUNT_DEVICE $SNAPSHOT_RW ;
if (( $? )); then
{
	$ECHO "snapshot: could not remount $SNAPSHOT_RW readonly";
	exit;
} fi;

