BEGIN   { FS=",";
          print "<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">"
          print "<html xmlns="http://www.w3.org/1999/xhtml">"
          print "<title>Usage Report</title>"
          print "<link rel="stylesheet" type="text/css" href="file:///tmp/format.css" />"
          print "</head><body>"}
NR == 1 { print "<H1>";
          for ( i = 1; i <= NF; i++ ) print $i ; 
          print "</H1>"} 
NR == 2 { print "<table>"
          print "<colgroup><col/><col/><col/><col/><col/><col/><col/><col/><col/></colgroup>"
          print "<tr>";
          for ( i = 1; i <= NF; i++ ) print "<th>" $i "</th>"; 
          print "</tr>"}           
NR > 2  { print "<tr>"; 
          for ( i = 1; i <= NF; i++ ) 
            print "<td" (i==2? " class=" ($i=="Directory"?"green":"blue"):"") ">" $i "</td>"; 
          print "</tr>"}
END     { print "</table><H5><i></i></H5></body></html>"}
