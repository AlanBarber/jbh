# jbh
(JBH) Jekyll Blog Helper - A shell script to help manage a jekyll weblog site

````
	Usage: jbh.sh [OPTIONS]...
	Jekyll Blog Helper - A command line blog management tool
	
	Options:
	
	  -b, --build   runs a jekyll build
	  -c, --clean   cleans out the site output directory
	  -n, --new     creates a new post
	  -p, --publish copies site via rcp/rsync to remote server
	  -s, --server  runs the jekyll server
	
	Modifier:
	
	  -d, --draft  create draft post or run build/serve w/ drafts
	
	Examples:
	
	  jbh.sh --new "Blog title"
	Creates a new post with the given title
	
	  jbh.sh --new "Blog title" "1/1/2015"
	Create a new post on a specific date
	
	  jbh.sh --new --draft "Blog title"
	Creates a new draft post with the given title
	
	  jbh.sh --build
	Builds the site
	
	  jbh.sh --publish
	Runs rcp/rsync to copy built site to a remote server
	* NOTE: Server settings are stored at top of script
	
	Report bugs to <github.com/alanbarber/jbh>

````