BEGIN   { FS=",";
          print "<html><head><style>table {font: 3ex gisha}"
          print ".green {border: 2px solid green; color:green}"
          print ".red {border: 2px solid red; color:red}"
          print "td:first-child {width:150px}</style></head>"
          print "<body><table width=500 border=2 cellspacing=2 cellpadding=2 border-collapse=collapse>"}
NR == 1 { print "<tr bgcolor=\"#FAD7A0\">";
          for ( i = 1; i <= NF; i++ ) print "<td><b>" $i "</b></td>"; 
          print "</tr>"} 
NR == 2 { print "<tr bgcolor=\"#FAD7A0\">";
          for ( i = 1; i <= NF; i++ ) print "<td><b>" $i "</b></td>"; 
          print "</tr>"}           
NR > 2  { print "<tr>"; 
          for ( i = 1; i <= NF; i++ ) 
            print "<td" (i==2? " class=" ($i=="Failure"?"red":"green"):"") ">" $i "</td>"; 
          print "</tr>"}
END     { print "</table></body></html>"}
