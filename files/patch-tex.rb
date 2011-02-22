--- lib/rabbit/parser/ext/tex.rb.orig	2010-12-31 18:25:18.000000000 +0900
+++ lib/rabbit/parser/ext/tex.rb	2011-02-23 00:32:23.000000000 +0900
@@ -45,6 +45,7 @@
           image_file = Tempfile.new("rabbit-image-mimetex")
           args = ["-e", image_file.path, "-f", path]
           commands = ["mimetex", "mimetex.cgi"]
+          ENV.store('PATH', ENV['PATH'] + ":%%LOCALBASE%%/www/mimetex/cgi-bin")
           if commands.any? {|command| SystemRunner.run(command, *args)}
             image_file
           else
