local stringUtil = {}

function stringUtil.removeLeadingTrailingWhitespaces(_string)
    return _string:match'^%s*(.*%S)' or ''
end

return stringUtil
