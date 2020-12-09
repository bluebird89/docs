# 获取当前脚本文件所在的路径
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# 字符串 startsWith 和 endsWith
if [[ $var == sub_string* ]]; then
    printf '%s\n' "var starts with sub_string."
fi
if [[ $var != sub_string* ]]; then
    printf '%s\n' "var does not start with sub_string."
fi

if [[ $var == *sub_string ]]; then
    printf '%s\n' "var ends with sub_string."
fi
if [[ $var != *sub_string ]]; then
    printf '%s\n' "var does not end with sub_string."
fi

# 判断字符串的内容是否是个数字
isNumber() {
  local str="$1"
  local re="^[0-9]+$"
  # 带小数点的格式
  # local re=" ^[0-9]+([.][0-9]+)?$"
  [[ "$str" =~ $re ]]
}

tests() {
  isNumber "$1" && echo "yes" || echo "no"
}

# tests ""
# tests "abc"
# tests "abc123"
# tests "1acb23"
# tests "123"
# tests "455"

# 获取字符串的子串
var=hello.world-1234.txt
#  从前向后截掉最短匹配 *. 的子串
echo "${var#*.}"
# 从前向后截掉最长匹配 *. 的字串
echo "${var##*.}"
# 从后向前截掉最短匹配 .* 的内容
echo "${var%.*}"
# 从后向前截掉最长匹配 .* 的内容
echo "${var%%.*}"
