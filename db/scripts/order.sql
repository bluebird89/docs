# 订单设计

# 订单设计
# 交易表
CREATE TABLE `transaction` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`order_sn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易单号',
`member_id` bigint(20) NOT NULL COMMENT '交易的用户ID',
`amount` decimal(8,2) NOT NULL COMMENT '交易金额',
`integral` int(11) NOT NULL DEFAULT '0' COMMENT '使用的积分',
`pay_state` tinyint(4) NOT NULL COMMENT '支付类型 0:余额 1:微信 2:支付宝 3:xxx',
`source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付来源 wx app web wap',
`status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态 -1：取消 0 未完成 1已完成 -2:异常',
`completion_time` int(11) NOT NULL COMMENT '交易完成时间',
`note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`),
KEY `transaction_order_sn_member_id_pay_state_source_status_index` (`order_sn`(191),`member_id`,`pay_state`,`source`(191),`status`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 支付记录表
CREATE TABLE `transaction_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `events` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '事件详情',
  `result` text COLLATE utf8mb4_unicode_ci COMMENT '结果详情',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 订单表
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `order_sn` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易号',
  `member_id` int(11) NOT NULL COMMENT '客户编号',
  `supplier_id` int(11) NOT NULL COMMENT '商户编码',
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户名称',
  `order_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态 0未付款,1已付款,2已发货,3已签收,-1退货申请,-2退货中,-3已退货,-4取消交易',
  `after_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户售后状态 0 未发起售后 1 申请售后 -1 售后已取消 2 处理中 200 处理完毕',
  `product_count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `product_amount_total` decimal(12,4) NOT NULL COMMENT '商品总价',
  `order_amount_total` decimal(12,4) NOT NULL default '0.0000' COMMENT '实际付款金额',
  `logistics_fee` decimal(12,4) NOT NULL COMMENT '运费金额',
  `address_id` int(11) NOT NULL COMMENT '收货地址编码',
  `pay_channel` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付渠道 0余额 1微信 2支付宝',
  `out_trade_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单支付单号',
  `escrow_trade_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方支付流水号',
  `pay_time` int(11) NOT NULL DEFAULT '0' COMMENT '付款时间',
  `delivery_time` int(11) NOT NULL DEFAULT '0' COMMENT '发货时间',
  `order_settlement_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单结算状态 0未结算 1已结算',
  `order_settlement_time` int(11) NOT NULL DEFAULT '0' COMMENT '订单结算时间',
  `is_package` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否是套餐',
  `is_integral` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否是积分产品',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_order_sn_unique` (`order_sn`),
  KEY `order_order_sn_member_id_order_status_out_trade_no_index` (`order_sn`,`member_id`,`order_status`,`out_trade_no`(191))
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 售后申请表
CREATE TABLE `order_returns_apply` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `order_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单单号',
   `order_detail_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '子订单编码',
   `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '售后单号',
   `member_id` int(11) NOT NULL COMMENT '用户编码',
   `state` tinyint(4) NOT NULL COMMENT '类型 0 仅退款 1退货退款',
   `product_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '货物状态 0:已收到货 1:未收到货',
   `why` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退换货原因',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 -1 拒绝 0 未审核 1审核通过',
   `audit_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
   `audit_why` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核原因',
   `note` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
   `created_at` timestamp NULL DEFAULT NULL,
   `updated_at` timestamp NULL DEFAULT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 售后表
CREATE TABLE `order_returns` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `returns_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '退货编号 供客户查询',
   `order_id` int(11) NOT NULL COMMENT '订单编号',
   `express_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流单号',
   `consignee_realname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人姓名',
   `consignee_telphone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话',
   `consignee_telphone2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备用联系电话',
   `consignee_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
   `consignee_zip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮政编码',
   `logistics_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '物流方式',
   `logistics_fee` decimal(12,2) NOT NULL COMMENT '物流发货运费',
   `order_logistics_status` int(11) DEFAULT NULL COMMENT '物流状态',
   `logistics_settlement_status` int(11) DEFAULT NULL COMMENT '物流结算状态',
   `logistics_result_last` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流最后状态描述',
   `logistics_result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流描述',
   `logistics_create_time` int(11) DEFAULT NULL COMMENT '发货时间',
   `logistics_update_time` int(11) DEFAULT NULL COMMENT '物流更新时间',
   `logistics_settlement_time` int(11) DEFAULT NULL COMMENT '物流结算时间',
   `returns_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0全部退单 1部分退单',
   `handling_way` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'PUPAWAY:退货入库;REDELIVERY:重新发货;RECLAIM-REDELIVERY:不要求归还并重新发货; REFUND:退款; COMPENSATION:不退货并赔偿',
   `returns_amount` decimal(8,2) NOT NULL COMMENT '退款金额',
   `return_submit_time` int(11) NOT NULL COMMENT '退货申请时间',
   `handling_time` int(11) NOT NULL COMMENT '退货处理时间',
   `remark` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '退货原因',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 评价数据表
CREATE TABLE `order_appraise` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单编码',
  `info` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `level` enum('-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '级别 -1差评 0中评 1好评',
  `desc_star` tinyint(4) NOT NULL COMMENT '描述相符 1-5',
  `logistics_star` tinyint(4) NOT NULL COMMENT '物流服务 1-5',
  `attitude_star` tinyint(4) NOT NULL COMMENT '服务态度 1-5',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_appraise_order_id_index` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# SSRS 报表中的 SQL
select distinct b.MaterialID as matl_def_id, c.Descript, case when right(b.MESOrderID, 12) < '001000000000' then right(b.MESOrderID, 9)
else right(b.MESOrderID, 12) end  as pom_order_id, a.LotName, a.SourceLotName as ComLot,
e.DefID as ComMaterials, e.Descript as ComMatDes, d.VendorID, d.DateCode,d.SNNote, b.OnPlantID,a.SNCUST
from
(
    select m.lotname, m.sourcelotname, m.opetypeid, m.OperationDate,n.SNCUST from View1 m
    left join co_sn_link_customer as n on n.SNMes=m.LotName
    where
    ( m.LotName in (select val from fn_String_To_Table(@sn,',',1)) or (@sn) = '') and
    ( m.sourcelotname in (select val from fn_String_To_Table(@BatchID,',',1)) or (@BatchID) = '')
    and (n.SNCust like '%'+ @SN_ext + '%' or (@SN_ext)='')
) a
left join
(
    select * from Table1 where SNType = 'IntSN'
    and SNRuleName = 'ProductSNRule'
    and OnPlantID=@OnPlant
) b on b.SN = a.LotName
inner join MMdefinitions as c on c.DefID = b.MaterialID
left join  Table1 as d on d.SN = a.SourceLotName
inner join MMDefinitions as e on e.DefID = d.MaterialID
where not exists (
 select distinct LotName, SourceLotName from ELCV_ASSEMBLE_OPS
where LotName = a.SourceLotName and SourceLotName = a.LotName
)
and (d.DateCode in (select val from fn_String_To_Table(@DCode,',',1)) or (@DCode) = '')
and (d.SNNote  like '%'+@SNNote+'%' or (@SNNote) = '')
and ((case when right(b.MESOrderID, 12) < '001000000000' then right(b.MESOrderID, 9)
else right(b.MESOrderID, 12) end) in (select val from fn_String_To_Table(@order_id,',',1)) or (@order_id) = '')
and (e.DefID in (select val from fn_String_To_Table(@comdef,',',1)) or (@comdef) = '')
--View1是一个嵌套两层的视图(出于保密性，实际名称可能不同)，里面有一张上亿数据的表和几张千万级数据的表做左连接查询
--Table1是一个数据记录超过1500万的表

# 分析如下：
-- 查询语句的 where 条件，有大量 @var in … or (@var =”) 的片段。
-- where 条件有 like ‘%’+@var+’%’。
-- where 条件有 case … end 函数。
-- 多次连接同一表查询，另外使用本身已嵌套的视图表，是不是必须，是否可替代？
-- SQL 语句有号，视图中也有号出现。

# 优化1：用存储过程改写，好处是设计灵活。
# 核心思想是：用一个或多个查询条件（查询条件要求至少输入一个）得到临时表，每个查询条件如果查到集合，就更新这张临时表，最后汇总的时候，只需判断这个临时表是否有值。
# 好处：
-- 省去了对变量进行 =@var or (@var=”)的判断。
-- 抛弃 SQL 拼接，提高代码可读性。

# 在书写存储过程，这个过程中要注意：
-- 尽量想办法使用临时表扫描替代全表扫描。
-- 抛弃 in 和 not in 语句，使用 exists 和 not exists 替代。
-- 和客户确认，模糊查询是否有必要，如没有必要，去掉 like 语句。
-- 注意建立适当的，符合场景的索引。
-- 踩死 “*” 号。
-- 避免在 where 条件中对字段进行函数操作。
-- 对实时性要求不高的报表，允许脏读（with(nolock)）。

/**
 * 某某跟踪报表
 **/
--exec spName1 '','','','','','','公司代号'
CREATE Procedure spName1
   @MESOrderID nvarchar(320), --工单号,最多30个
   @LotName nvarchar(700),    --产品序列号,最多50个
   @DateCode nvarchar(500),   --供应商批次号,最多30个
   @BatchID nvarchar(700),    --组装件序列号/物料批号,最多50个
   @comdef nvarchar(700),     --组装件物料编码,最多30个
   @SNCust nvarchar(1600),    --外部序列号,最多50个
   @OnPlant nvarchar(20)      --平台
AS
BEGIN
    SET NOCOUNT ON;
    /**
     * 1)定义全局的临时表，先根据六个查询条件的任意一个，得出临时表结果
     **/
    CREATE TABLE #FinalLotName
    (
        LotName NVARCHAR(50),       --序列号
        SourceLotName NVARCHAR(50), --来源序列号
        SNCust NVARCHAR(128)        --外部序列号
    )
    --1.1
    IF @LotName<>''
    BEGIN
        SELECT Val INTO #WorkLot FROM fn_String_To_Table(@LotName,',',1)
        SELECT LotPK,LotName INTO #WorkLotPK FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLot b WHERE b.Val=MMLots.LotID)

        --求SourceLotPK只能在这里求
        SELECT a.LotPK,a.SourceLotPK into #WorkSourcePK FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotPK b WHERE b.LotPK=a.LotPK) AND a.SourceLotPK IS NOT NULL

        SELECT a.LotPK,a.SourceLotPK,b.LotName INTO #WorkSourcePK2 FROM #WorkSourcePK a JOIN #WorkLotPK b ON a.LotPK=b.LotPK

        INSERT INTO #FinalLotName SELECT a.LotName,b.LotName AS SourceLotName,NULL FROM #WorkSourcePK2 a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.SourceLotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定
        SELECT a.LotName,a.SourceLotName,b.SNCust INTO #FinalLotNameX1 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
        DELETE FROM #FinalLotName
        INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX1
    END
    --1.2
    IF @BatchID<>''
    BEGIN
        SELECT Val INTO #WorkSourceLot FROM fn_String_To_Table(@BatchID,',',1)
        IF EXISTS(SELECT 1 FROM #FinalLotName)--如果@LotName也不为空
        BEGIN
            SELECT a.LotName,a.SourceLotName,a.SNCust INTO #FinalLotNameX2 FROM #FinalLotName a WHERE EXISTS(SELECT 1 FROM #WorkSourceLot b WHERE a.SourceLotName=b.Val)
            DELETE FROM #FinalLotName
            INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX2
        END
        ELSE --@LotName条件为空
        BEGIN
            SELECT LotPK AS SourceLotPK,LotName AS SourceLotName INTO #2 FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkSourceLot b WHERE b.Val=MMLots.LotID)
            SELECT a.LotPK,a.SourceLotPK into #21 FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #2 b WHERE b.SourceLotPK=a.SourceLotPK)
            SELECT a.LotPK,a.SourceLotPK,b.SourceLotName INTO #22 FROM #21 a JOIN #2 b ON a.SourceLotPK=b.SourceLotPK
            INSERT INTO #FinalLotName SELECT b.LotName,a.SourceLotName,NULL FROM #22 a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.LotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定
            SELECT a.LotName,a.SourceLotName,b.SNCust INTO #FinalLotNameX21 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
            DELETE FROM #FinalLotName
            INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX21
        END
    END
    --1.3
    IF @SNCust<>''
    BEGIN
        SELECT Val INTO #WorkCustomSN FROM fn_String_To_Table(@SNCust,',',1)
        IF EXISTS(SELECT 1 FROM #FinalLotName)--前面两个条件至少有一个有值
        BEGIN
            SELECT a.LotName,a.SourceLotName,a.SNCust INTO #FinalLotNameX3 FROM #FinalLotName a WHERE EXISTS(SELECT 1 FROM #WorkCustomSN b WHERE a.SNCust=b.Val)
            DELETE FROM #FinalLotName
            INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX3
        END
        ELSE
        BEGIN
            SELECT a.SNMes INTO #WorkLotX FROM CO_SN_LINK_CUSTOMER a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkCustomSN b WHERE a.SNCust=b.Val)
            -------------------以下逻辑和变量1(@LotName)类似[先根据外部序列号求解序列号,再照搬第一个判断变量的方式]
            SELECT LotPK,LotName INTO #WorkLotPKX FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotX b WHERE b.SNMes=MMLots.LotID)

            --求SourceLotPK只能在这里求
            SELECT a.LotPK,a.SourceLotPK into #WorkSourcePKX FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotPKX b WHERE b.LotPK=a.LotPK) AND a.SourceLotPK IS NOT NULL

            SELECT a.LotPK,a.SourceLotPK,b.LotName INTO #WorkSourcePK2X FROM #WorkSourcePKX a JOIN #WorkLotPKX b ON a.LotPK=b.LotPK

            INSERT INTO #FinalLotName SELECT a.LotName,b.LotName AS SourceLotName,NULL FROM #WorkSourcePK2X a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.SourceLotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定
            SELECT a.LotName,a.SourceLotName,b.SNCust INTO #FinalLotNameX31 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
            DELETE FROM #FinalLotName
            INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX31
            -----------------------
        END
    END

    /**
     * 2)定义全局的临时表，用于替换第一个全局临时表。
     **/
    CREATE TABLE #FinalCO_SN
    (
        SN NVARCHAR(50),
        SourceSN NVARCHAR(50),
        SNCust NVARCHAR(128),
        matl_def_id NVARCHAR(50),--sn的物料ID
        ComMaterials NVARCHAR(50),  --SourceSN的物料ID
        MESOrderID NVARCHAR(20),
        OnPlantID NVARCHAR(20),
        VendorID NVARCHAR(20),
        DateCode NVARCHAR(20) ,
        SNNote NVARCHAR(512)
    )
    --2.1
    IF @MESOrderID<>''
    BEGIN
        -------------------------------将MESOrderID做特殊处理-----------------------------------
        SELECT Val INTO #WorkMESOrderID FROM fn_String_To_Table(@MESOrderID,',',1)
        IF @OnPlant='Comba'
        BEGIN
            UPDATE #WorkMESOrderID SET Val='C000'+Val WHERE LEN(Val)=9
        END
        ELSE
        BEGIN
            UPDATE #WorkMESOrderID SET Val='W000'+Val WHERE LEN(Val)=9
        END
        SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #WorkCO_SN1 FROM CO_SN_GENERATION a WITH(NOLOCK)
        WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
        AND EXISTS(SELECT 1 FROM #WorkMESOrderID b WHERE a.MESOrderID=b.Val)
        ------------------------------------------------------------------------------------------
        --条件判断(逻辑分析)开始
        IF EXISTS(SELECT 1 FROM #FinalLotName)--如果前面判断的查询条件有值
        BEGIN
            --查出SourceLotName对应的查询字段
            SELECT a.SN AS SourceLotName,a.VendorID,a.DateCode,a.SNNote,a.MaterialID AS ComMaterials INTO #SourceLotNameTable FROM CO_SN_GENERATION a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.SourceLotName)

            INSERT INTO #FinalCO_SN
            SELECT a.LotName,a.SourceLotName,d.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
            LEFT JOIN #WorkCO_SN1 b ON a.LotName=b.SN
            LEFT JOIN #SourceLotNameTable c ON a.SourceLotName=c.SourceLotName
            LEFT JOIN CO_SN_LINK_CUSTOMER d WITH(NOLOCK) ON a.LotName=d.SNMes
        END
        ELSE
        BEGIN
            --已知SN集合求解对应的SourceSN和SNCust集合------------------------------------------
            SELECT LotPK,LotName INTO #WorkLotPK410 FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkCO_SN1 b WHERE b.SN=MMLots.LotID)
            SELECT a.LotPK,a.SourceLotPK into #WorkSourcePK420 FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotPK410 b WHERE b.LotPK=a.LotPK) AND a.SourceLotPK IS NOT NULL
            SELECT a.LotPK,a.SourceLotPK,b.LotName INTO #WorkSourcePK430 FROM #WorkSourcePK420 a JOIN #WorkLotPK410 b ON a.LotPK=b.LotPK
            INSERT INTO #FinalLotName SELECT a.LotName,b.LotName AS SourceLotName,NULL FROM #WorkSourcePK430 a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.SourceLotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定

            SELECT a.LotName,a.SourceLotName,b.SNCust INTO #FinalLotNameX440 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
            DELETE FROM #FinalLotName
            INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #FinalLotNameX440
            -------------------------------------------------------------------------------------
            SELECT a.SN AS SourceLotName,a.VendorID,a.DateCode,a.SNNote,a.MaterialID AS ComMaterials INTO #SourceLotNameTable2 FROM CO_SN_GENERATION a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.SourceLotName)

            INSERT INTO #FinalCO_SN
            SELECT a.LotName,a.SourceLotName,a.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
            LEFT JOIN #WorkCO_SN1 b ON a.LotName=b.SN
            LEFT JOIN #SourceLotNameTable2 c ON a.SourceLotName=c.SourceLotName
        END
    END
    --2.2
    IF @DateCode<>''
    BEGIN
        SELECT Val INTO #WorkDateCode FROM fn_String_To_Table(@DateCode,',',1)
        --此@DataCode条件求解出来的是SourceSN
        SELECT SN AS SourceSN,MaterialID AS ComMaterials,VendorID,DateCode,SNNote INTO #WorkSourceSNT1 FROM CO_SN_GENERATION a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkDateCode b WHERE a.DateCode=b.Val)
        ----------------------------------------------------------------------------------------------------
        --条件判断(逻辑分析)开始
        IF EXISTS(SELECT 1 FROM #FinalCO_SN)--如果前面判断的查询条件有值
        BEGIN
            SELECT a.LotName,a.SourceLotName,a.SNCust,a.MaterialID,a.ComMaterials,a.MESOrderID,a.OnPlantID,a.VendorID,a.DateCode,a.SNNote INTO #TMP51 FROM #FinalCO_SN a WHERE EXISTS (SELECT 1 FROM #WorkDateCode b WHERE a.DateCode=b.Val)
            DELETE FROM #FinalCO_SN
            INSERT INTO #FinalCO_SN SELECT LotName,SourceLotName,SNCust,MaterialID,ComMaterials,MESOrderID,OnPlantID,VendorID,DateCode,SNNote FROM #TMP51
        END
        ELSE
        BEGIN
            IF EXISTS(SELECT 1 FROM #FinalLotName)
            BEGIN
            --查出SourceLotName对应的查询字段
            SELECT a.SourceSN,a.VendorID,a.DateCode,a.SNNote,a.ComMaterials INTO #SourceLTX5 FROM #WorkSourceSNT1 a WHERE EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SourceSN=b.SourceLotName)
            --查出SN对应的查询字段
            SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #WorkSNT510 FROM CO_SN_GENERATION a WITH(NOLOCK)
            WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
            AND EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.LotName)

            INSERT INTO #FinalCO_SN
            SELECT a.LotName,a.SourceLotName,d.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
            LEFT JOIN #WorkSNT510 b ON a.LotName=b.SN
            LEFT JOIN #WorkSourceSNT1 c ON a.SourceLotName=c.SourceSN
            LEFT JOIN CO_SN_LINK_CUSTOMER d WITH(NOLOCK) ON a.LotName=d.SNMes

            END
            ELSE
            BEGIN
                --已知SourceSN集合求解对应的SN和SNCust集合------------------------------------------
                SELECT LotPK AS SourceLotPK,LotName AS SrouceLotName INTO #WorkLotX510 FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkSourceSNT1 b WHERE b.SourceSN=MMLots.LotID)
                SELECT a.LotPK,a.SourceLotPK into #WorkLotX520 FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotX510 b WHERE b.SourceLotPK=a.SourceLotPK)
                SELECT a.LotPK,a.SourceLotPK,b.SrouceLotName INTO #WorkLotX530 FROM #WorkLotX520 a JOIN #WorkLotX510 b ON a.SourceLotPK=b.SourceLotPK

                INSERT INTO #FinalLotName SELECT b.LotName,a.SrouceLotName,NULL FROM #WorkLotX530 a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.LotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定

                SELECT a.LotName,a.SourceLotName,b.SNCust INTO #WorkLotX540 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
                DELETE FROM #FinalLotName
                INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #WorkLotX540
                -------------------------------------------------------------------------------------
                SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #WorkLotX550 FROM CO_SN_GENERATION a WITH(NOLOCK)
                WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
                AND EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.LotName)

                INSERT INTO #FinalCO_SN
                SELECT a.LotName,a.SourceLotName,a.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
                LEFT JOIN #WorkLotX550 b ON a.LotName=b.SN
                LEFT JOIN #WorkSourceSNT1 c ON a.SourceLotName=c.SourceSN
            END
        END
    END
    --2.3
    IF @comdef<>''
    BEGIN
        SELECT Val INTO #WorkComdef FROM fn_String_To_Table(@comdef,',',1)
        --此@comdef条件求解出来的是SourceSN
        SELECT SN AS SourceSN,MaterialID AS ComMaterials,VendorID,DateCode,SNNote INTO #WorkSourceSNT16 FROM CO_SN_GENERATION a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkComdef b WHERE a.MaterialID=b.Val)
        ----------------------------------------------------------------------------------------------------
        --条件判断(逻辑分析)开始
        IF EXISTS(SELECT 1 FROM #FinalCO_SN)--如果前面判断的查询条件有值
        BEGIN
            SELECT a.LotName,a.SourceLotName,a.SNCust,a.MaterialID,a.ComMaterials,a.MESOrderID,a.OnPlantID,a.VendorID,a.DateCode,a.SNNote INTO #TMP516 FROM #FinalCO_SN a WHERE EXISTS (SELECT 1 FROM #WorkComdef b WHERE a.matl_def_id=b.Val)
            DELETE FROM #FinalCO_SN
            INSERT INTO #FinalCO_SN SELECT LotName,SourceLotName,SNCust,MaterialID,ComMaterials,MESOrderID,OnPlantID,VendorID,DateCode,SNNote FROM #TMP516
        END
        ELSE
        BEGIN
            IF EXISTS(SELECT 1 FROM #FinalLotName)
            BEGIN
            --查出SourceLotName对应的查询字段
            SELECT a.SourceSN,a.VendorID,a.DateCode,a.SNNote,a.ComMaterials INTO #SourceLTX56 FROM #WorkSourceSNT16 a WHERE EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SourceSN=b.SourceLotName)
            --查出SN对应的查询字段
            SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #WorkSNT5106 FROM CO_SN_GENERATION a WITH(NOLOCK)
            WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
            AND EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.LotName)

            INSERT INTO #FinalCO_SN
            SELECT a.LotName,a.SourceLotName,d.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
            LEFT JOIN #WorkSNT5106 b ON a.LotName=b.SN
            LEFT JOIN #WorkSourceSNT16 c ON a.SourceLotName=c.SourceSN
            LEFT JOIN CO_SN_LINK_CUSTOMER d WITH(NOLOCK) ON a.LotName=d.SNMes

            END
            ELSE
            BEGIN
                --已知SourceSN集合求解对应的SN和SNCust集合------------------------------------------
                SELECT LotPK AS SourceLotPK,LotName AS SrouceLotName INTO #WorkLotX5106 FROM MMLots WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkSourceSNT16 b WHERE b.SourceSN=MMLots.LotID)
                SELECT a.LotPK,a.SourceLotPK into #WorkLotX5206 FROM MMLotOperations a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #WorkLotX5106 b WHERE b.SourceLotPK=a.SourceLotPK)
                SELECT a.LotPK,a.SourceLotPK,b.SrouceLotName INTO #WorkLotX5306 FROM #WorkLotX5206 a JOIN #WorkLotX5106 b ON a.SourceLotPK=b.SourceLotPK

                INSERT INTO #FinalLotName SELECT b.LotName,a.SrouceLotName,NULL FROM #WorkLotX5306 a JOIN (SELECT LotPK,LotName FROM MMLots WITH(NOLOCK) ) b on a.LotPK=b.LotPK --b的里面加不加WHERE RowDeleted=0待确定

                SELECT a.LotName,a.SourceLotName,b.SNCust INTO #WorkLotX5406 FROM #FinalLotName a LEFT JOIN CO_SN_LINK_CUSTOMER b WITH(NOLOCK) ON a.LotName=b.SNMes
                DELETE FROM #FinalLotName
                INSERT INTO #FinalLotName SELECT LotName,SourceLotName,SNCust FROM #WorkLotX5406
                -------------------------------------------------------------------------------------
                SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #WorkLotX5506 FROM CO_SN_GENERATION a WITH(NOLOCK)
                WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
                AND EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.LotName)

                INSERT INTO #FinalCO_SN
                SELECT a.LotName,a.SourceLotName,a.SNCust,b.MaterialID,c.ComMaterials,b.MESOrderID,b.OnPlantID,c.VendorID,c.DateCode,c.SNNote FROM #FinalLotName a
                LEFT JOIN #WorkLotX5506 b ON a.LotName=b.SN
                LEFT JOIN #WorkSourceSNT16 c ON a.SourceLotName=c.SourceSN
            END
        END
    END

    /**
     * 3)条件判断结束
     **/
    IF EXISTS(SELECT 1 FROM #FinalLotName)
    BEGIN
        IF EXISTS(SELECT 1 FROM #FinalCO_SN)
        BEGIN--3.1
            SELECT a.matl_def_id,b.Descript,a.MESOrderID AS pom_order_id,a.SN AS LotName,a.SourceSN AS ComLot,
                   a.ComMaterials,c.Descript AS ComMatDes,a.VendorID,a.DateCode,a.SNNote,
                   OnPlantID,SNCust FROM #FinalCO_SN a
                   JOIN MMDefinitions b WITH(NOLOCK) ON a.matl_def_id=b.DefID
                   JOIN MMDefinitions c WITH(NOLOCK) ON a.ComMaterials=c.DefID
            WHERE NOT EXISTS(select distinct SN, SourceSN from #FinalCO_SN x
                             where x.SN = a.SourceSN and x.SourceSN = a.SN)
        END
        ELSE
        BEGIN--3.2
            --3.2.1求解SN的必查字段
            SELECT SN,MaterialID,MESOrderID,OnPlantID INTO #FinalSNX1 FROM CO_SN_GENERATION a WITH(NOLOCK)
            WHERE SNType='IntSN' AND SNRuleName = 'ProductSNRule' AND OnPlantID=@OnPlant
            AND EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.LotName)
            --3.2.2求解SourceSN的必查字段
            SELECT a.SN AS SourceLotName,a.VendorID,a.DateCode,a.SNNote,a.MaterialID AS ComMaterials INTO #FinalSNX2 FROM CO_SN_GENERATION a WITH(NOLOCK) WHERE EXISTS(SELECT 1 FROM #FinalLotName b WHERE a.SN=b.SourceLotName)

            SELECT b.MaterialID AS matl_def_id,x.Descript,b.MESOrderID AS pom_order_id,b.SN AS LotName,c.SourceLotName AS ComLot,c.ComMaterials,y.Descript AS ComMatDes,c.VendorID,c.DateCode,c.SNNote,b.OnPlantID,a.SNCust
            FROM #FinalLotName a
            LEFT JOIN #FinalSNX1 b ON a.LotName=b.SN
            LEFT JOIN #FinalSNX2 c ON a.SourceLotName=c.SourceLotName
            JOIN MMDefinitions x WITH(NOLOCK) ON b.MaterialID=x.DefID
            JOIN MMDefinitions y WITH(NOLOCK) ON c.ComMaterials=y.DefID
            WHERE NOT EXISTS(
                SELECT DISTINCT * FROM #FinalLotName z
                WHERE z.LotName=a.SourceLotName and z.SourceLotName=a.LotName
            )
        END
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT 1 FROM #FinalCO_SN)
        BEGIN--3.3
            SELECT a.matl_def_id,b.Descript,a.MESOrderID AS pom_order_id,a.SN AS LotName,a.SourceSN AS ComLot,
                   a.ComMaterials,c.Descript AS ComMatDes,a.VendorID,a.DateCode,a.SNNote,
                   OnPlantID,SNCust FROM #FinalCO_SN a
                   JOIN MMDefinitions b WITH(NOLOCK) ON a.matl_def_id=b.DefID
                   JOIN MMDefinitions c WITH(NOLOCK) ON a.ComMaterials=c.DefID
            WHERE NOT EXISTS(select distinct SN, SourceSN from #FinalCO_SN x
                             where x.SN = a.SourceSN and x.SourceSN = a.SN)
        END
        ELSE
        BEGIN--3.4
            PRINT 'There is no queryable condition,please enter at less a query conditon.'
        END
    END

END
GO
