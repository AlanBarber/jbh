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
	  -s, --serve   runs the jekyll server
	  -v, --version displays version of the script
	
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

### Install

Copy the *jbh.sh* script into the base folder of the your Jekyll site.

Open the script with your editor of choice and there are several settings you
will need to setup for publishing to your remote server.

### How To Use

#### Create Post

````
	$ jbh.sh --new "Enter Your Post Title"
```` 

This will create a properly formated Jekyll post file and a cororlating asset
folder for storing photos and files that are part of your post.

#### Build The Site

````
	$ jbh.sh --build
````

This runs the Jekyll build to update the local copy of your site.

#### Publish To Your Web Server

````
	$ jbh.sh --publish
````

This pushes the changes via scp or rsync to your remote server