signature Idl_TOKENS =
sig
type ('a,'b) token
type svalue
val EOF:  'a * 'a -> (svalue,'a) token
val YFIXEDPTLITERAL:  'a * 'a -> (svalue,'a) token
val YWSTRINGLITERAL:  'a * 'a -> (svalue,'a) token
val YSTRINGLITERAL:  'a * 'a -> (svalue,'a) token
val YFLOATLITERAL:  'a * 'a -> (svalue,'a) token
val YWCHARLITERAL:  'a * 'a -> (svalue,'a) token
val YCHARLITERAL:  'a * 'a -> (svalue,'a) token
val YHEXINTEGER:  'a * 'a -> (svalue,'a) token
val YOCTINTEGER:  'a * 'a -> (svalue,'a) token
val YINTEGER: (int option) *  'a * 'a -> (svalue,'a) token
val YID: (string) *  'a * 'a -> (svalue,'a) token
val YDBLRIGHTANGLE:  'a * 'a -> (svalue,'a) token
val YDBLLEFTANGLE:  'a * 'a -> (svalue,'a) token
val YRIGHTBRACKET:  'a * 'a -> (svalue,'a) token
val YLEFTBRACKET:  'a * 'a -> (svalue,'a) token
val YFWDSLASH:  'a * 'a -> (svalue,'a) token
val YASTERISK:  'a * 'a -> (svalue,'a) token
val YCARAT:  'a * 'a -> (svalue,'a) token
val YAND:  'a * 'a -> (svalue,'a) token
val YMOD:  'a * 'a -> (svalue,'a) token
val YTILDE:  'a * 'a -> (svalue,'a) token
val YPLUS:  'a * 'a -> (svalue,'a) token
val YMINUS:  'a * 'a -> (svalue,'a) token
val YVBAR:  'a * 'a -> (svalue,'a) token
val YEQUALS:  'a * 'a -> (svalue,'a) token
val YRIGHTANGLE:  'a * 'a -> (svalue,'a) token
val YLEFTANGLE:  'a * 'a -> (svalue,'a) token
val YRIGHTBRACE:  'a * 'a -> (svalue,'a) token
val YLEFTBRACE:  'a * 'a -> (svalue,'a) token
val YRIGHTPAREN:  'a * 'a -> (svalue,'a) token
val YLEFTPAREN:  'a * 'a -> (svalue,'a) token
val YCOLONCOLON:  'a * 'a -> (svalue,'a) token
val YCOLON:  'a * 'a -> (svalue,'a) token
val YCOMMA:  'a * 'a -> (svalue,'a) token
val YDOT:  'a * 'a -> (svalue,'a) token
val YSEMI:  'a * 'a -> (svalue,'a) token
val YWSTRING:  'a * 'a -> (svalue,'a) token
val YWCHAR:  'a * 'a -> (svalue,'a) token
val YVOID:  'a * 'a -> (svalue,'a) token
val YVALUETYPE:  'a * 'a -> (svalue,'a) token
val YVALUEBASE:  'a * 'a -> (svalue,'a) token
val YUNION:  'a * 'a -> (svalue,'a) token
val YUNSIGNED:  'a * 'a -> (svalue,'a) token
val YTYPEDEF:  'a * 'a -> (svalue,'a) token
val YTRUNCATABLE:  'a * 'a -> (svalue,'a) token
val YTRUE:  'a * 'a -> (svalue,'a) token
val YSWITCH:  'a * 'a -> (svalue,'a) token
val YSUPPORTS:  'a * 'a -> (svalue,'a) token
val YSTRUCT:  'a * 'a -> (svalue,'a) token
val YSTRING:  'a * 'a -> (svalue,'a) token
val YSHORT:  'a * 'a -> (svalue,'a) token
val YSEQUENCE:  'a * 'a -> (svalue,'a) token
val YREADONLY:  'a * 'a -> (svalue,'a) token
val YRAISES:  'a * 'a -> (svalue,'a) token
val YPUBLIC:  'a * 'a -> (svalue,'a) token
val YPRIVATE:  'a * 'a -> (svalue,'a) token
val YOUT:  'a * 'a -> (svalue,'a) token
val YONEWAY:  'a * 'a -> (svalue,'a) token
val YOCTET:  'a * 'a -> (svalue,'a) token
val YOBJECT:  'a * 'a -> (svalue,'a) token
val YNATIVE:  'a * 'a -> (svalue,'a) token
val YMODULE:  'a * 'a -> (svalue,'a) token
val YLONG:  'a * 'a -> (svalue,'a) token
val YLOCAL:  'a * 'a -> (svalue,'a) token
val YINTERFACE:  'a * 'a -> (svalue,'a) token
val YINOUT:  'a * 'a -> (svalue,'a) token
val YIN:  'a * 'a -> (svalue,'a) token
val YFLOAT:  'a * 'a -> (svalue,'a) token
val YFIXED:  'a * 'a -> (svalue,'a) token
val YFALSE:  'a * 'a -> (svalue,'a) token
val YFACTORY:  'a * 'a -> (svalue,'a) token
val YENUM:  'a * 'a -> (svalue,'a) token
val YEXCEPTION:  'a * 'a -> (svalue,'a) token
val YDOUBLE:  'a * 'a -> (svalue,'a) token
val YDEFAULT:  'a * 'a -> (svalue,'a) token
val YCUSTOM:  'a * 'a -> (svalue,'a) token
val YCONTEXT:  'a * 'a -> (svalue,'a) token
val YCONST:  'a * 'a -> (svalue,'a) token
val YCHAR:  'a * 'a -> (svalue,'a) token
val YCASE:  'a * 'a -> (svalue,'a) token
val YBOOLEAN:  'a * 'a -> (svalue,'a) token
val YATTRIBUTE:  'a * 'a -> (svalue,'a) token
val YANY:  'a * 'a -> (svalue,'a) token
val YABSTRACT:  'a * 'a -> (svalue,'a) token
end
signature Idl_LRVALS=
sig
structure Tokens : Idl_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
