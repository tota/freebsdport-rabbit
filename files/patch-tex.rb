--- lib/rabbit/parser/ext/tex.rb.orig	2010-12-31 18:25:18.000000000 +0900
+++ lib/rabbit/parser/ext/tex.rb	2011-02-23 21:35:40.000000000 +0900
@@ -44,7 +44,7 @@
         def make_image_by_mimeTeX(path, prop, logger)
           image_file = Tempfile.new("rabbit-image-mimetex")
           args = ["-e", image_file.path, "-f", path]
-          commands = ["mimetex", "mimetex.cgi"]
+          commands = ["mimetex", "mimetex.cgi", "%%LOCALBASE%%/www/mimetex/cgi-bin/mimetex.cgi"]
           if commands.any? {|command| SystemRunner.run(command, *args)}
             image_file
           else
