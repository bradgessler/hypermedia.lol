# Custom domain for GitHub Pages. Written into ./build so it ships with the
# deploy artifact. It lives here rather than in ./pages because Sitepress
# treats extensionless files in ./pages as templates.
DOMAIN = "hypermedia.lol"

desc "Remove all files from the build directory"
task :clean do
  sh "rm -rf ./build"
end

desc "Compile the sitepress site into ./build"
task :compile do
  sh "bundle exec sitepress compile"
end

desc "Write the GitHub Pages CNAME file into ./build"
task :cname do
  File.write "./build/CNAME", "#{DOMAIN}\n"
end

task default: %w[clean compile cname]
