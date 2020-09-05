#!/bin/sh

# CommentedOutRegex1='^['$'\n''[:space:]]*\/\*';
# CommentedOutRegex2='\*\/['$'\n''[:space:]]*$';
# 
# if [[ $POPCLIP_TEXT =~ $CommentedOutRegex1 ]]; then
#   if [[ $POPCLIP_TEXT =~ $CommentedOutRegex2 ]]; then
#     echo -n "$POPCLIP_TEXT" | perl -pe's/^([\s\n]*)\/\*|\*\/([\s\n]*)$/$1/sg';
#     exit 0
#   fi
# fi
# 
# #echo "/*"$'\n'"$POPCLIP_TEXT$"'\n'"*/";
# #echo -ne "/*\n$POPCLIP_TEXT\n*/";
# echo -n "/*$POPCLIP_TEXT*/";

# test case:
# POPCLIP_TEXT=$(cat <<'EOF'
# /* ssfaf
# * fadffa
# *
# * ss
# */ 
# EOF
# )

COPY_TEXT="$POPCLIP_TEXT"
CLIPBORAD_TEXT=$(echo "$COPY_TEXT" | awk 'BEGIN{RS="\n";start=0;end=0;content="";} {
if (end == 1) next;
if (/^[ \b\t\r]*\/\*/) {
   sub(/^[ \b\t\r]*\/\*/,"");
   sub(/\n/," ");
   content=$0;
   start=1;
}
if (start == 0) next;
if (/\*\/[ \b\t\r\n]*$/) {
    sub(/\*\//,"");
    content=content""$0;
    end=1;
    next;
}
if (/^[ \b\t\r]*\*[ \b\t\r\n]*$/) {
    sub(/\*/,"");
    content=content"\n";
    next
}
if (/^[ \b\t\r]*\*/) {
    sub(/^[ \b\t\r]*\*/,"");
    sub(/\n/," ");
    content=content""$0;
    next
}
} END {print content}')

echo "$CLIPBORAD_TEXT"
