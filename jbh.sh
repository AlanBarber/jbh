#/bin/bash
#----------------------------------------
# JBH - Jekyll Blog Helper
_version="1.1.0"
# http://github.com/alanbarber/jbh
#----------------------------------------
# Settings
# Always set leading and trailing slashes in path!

_sitePath="/_site/"	
_postPath="/_posts/"
_draftPath="/_drafts/"
_assetPath="/assets/"
_excerptSeparator="/--more--/"

_publishUseRsync="true"
_publishUser="username"
_publishServer="server.tld"
_publishPath="/home/username/public_html/"

########################################
# DO NOT EDIT BELOW THIS LINE
########################################
# Version
function fnVersion {
	echo "Jekyll Blog Helper $_version"
	echo "Report bugs to <github.com/alanbarber/jbh>"
	echo ""
}

# Help Info
function fnHelpInfo {
	echo "Usage: jbh.sh [OPTIONS]..."
	echo "Jekyll Blog Helper $_version - A command line blog management tool"
	echo ""
	echo "Options:"
	echo ""
	echo "  -b, --build    runs a jekyll build"
	echo "  -c, --clean    cleans out the site output directory"
	echo "  -n, --new      creates a new post"
	echo "  -p, --publish  copies site via rcp/rsync to remote server"
	echo "  -s, --serve    runs the jekyll server"
	echo "  -v, --version  displays version of the script"
	echo ""
	echo "Modifier:"
	echo ""
	echo "  -d, --draft    create draft post or run build/serve w/ drafts" 
	echo ""
	echo "Examples:"
	echo ""
	echo "  jbh.sh --new \"Blog title\""
	echo "    Creates a new post with the given title"
	echo ""
	echo "  jbh.sh --new \"Blog title\" \"1/1/2015\""
	echo "    Create a new post on a specific date"
	echo ""
	echo "  jbh.sh --new --draft \"Blog title\""
	echo "    Creates a new draft post with the given title"
	echo ""
	echo "  jbh.sh --build"
	echo "    Builds the site"
	echo ""
	echo "  jbh.sh --publish"
	echo "    Runs rcp/rsync to copy built site to a remote server"
	echo "    * NOTE: Server settings are stored at top of script"
	echo ""
	echo "Report bugs to <github.com/alanbarber/jbh>"
	echo ""
}
# Build
function fnBuild {
	echo "Running Jekyll build..."
	if [[ "$1" == "-d" || "$1" == "--draft" ]]; then
		echo "Including drafts..."
		jekyll build --destination ".$_sitePath" --drafts
	else
		jekyll build --destination ".$_sitePath"
	fi
}
# Clean
function fnClean {
	echo "Cleaning site directory '$_sitePath'..."
	# we remove and recreate the dir to make sure all files
	# including hidden dot files (.htaccess, etc) are gone
	rm -rf .$_sitePath
	mkdir -p .$_sitePath
}
# New Post
function fnNew {
	echo "Creating new post..."
	if [[ "$1" == "-d" || "$1" == "--draft" ]]; then
		echo "  Making post a draft..."
		_title="$2"
		if [ "$3" == "" ]; then
			_date=$(date +%Y-%m-%d)
		else
			_date=$(date -d $3 +%Y-%m-%d)
		fi
		_path="$_draftPath"
	else
		_title="$1"
		if [ "$2" == "" ]; then
			_date=$(date +%Y-%m-%d)
		else
			_date=$(date -d $2 +%Y-%m-%d)
		fi		
		_path="$_postPath"
	fi
	# setup vars
	# lowercase, remove non alphanumerics or spaces, convert spaces to dash
	_fileTitle=$(echo $_title | sed -e 's/\(.*\)/\L\1/')
	_fileTitle=$(echo $_fileTitle | sed -e 's/[[:punct:]]//g')
	_fileTitle=$(echo $_fileTitle | sed -e 's/\s/-/g')

	_outputFile="$_path$_date-$_fileTitle.md"
	_assetDir="$_assetPath$(date -d $_date +%Y)/$(date -d $_date +%m)/$(date -d $_date +%d)/$_fileTitle"

	# Create file and write Jekyll header info
	echo "  Creating file '$_outputFile'..."
	echo "    Title: $_title"
	echo "    Date: $_date"

	echo "---" > ".$_outputFile"
	echo "layout: post" >> ".$_outputFile"
	echo "title: \"$_title\"" >> ".$_outputFile"
	echo "date: $_date" >> ".$_outputFile"
	echo "categories: []" >> ".$_outputFile"
	echo "---" >> ".$_outputFile"
	echo -e "\n\n$_excerptSeparator\n\n[assets]: $_assetDir" >> ".$_outputFile"
	
	# Create asset directory for post
	echo "  Creating asset folder '$_assetDir'"
	mkdir -p ".$_assetDir"
}
# Publish
function fnPublish {
	echo "Publishing site to remote server..."
	# call rsync using settings	
	if [[ "$_publishPath" == "" || "$_publishUser" == "" || "$_publishServer" == "" ]]; then
		echo "  Error: Unable to determine settings to publish to remote server!"
		echo ""
		exit 1
	else
		if [[ "$_publishUseRsync" == "" || "$_publishUseRsync" == "0" || "$_publishUseRsync" == "false" ]]; then
			scp -r .$_sitePath* $_publishUser@$_publishServer:$_publishPath
		else
			rsync --compress --recursive --checksum --itemize-changes --delete .$_sitePate* $_publishUser@$_publishServer:$_publishPath
		fi
	fi
}
# Server
function fnServe {
	echo "Running Jekyll server..."
	if [[ "$1" == "-d" || "$1" == "--draft" ]]; then
		echo "Including drafts..."
		jekyll serve --destination ".$_sitePath" --drafts
	else
		jekyll serve --destination ".$_sitePath"
	fi
}
# Process command line# Parse options
case "$1" in
	-b)
		fnBuild "$2"
		;;
	--build)
		fnBuild "$2"
		;;
	-c)
		fnClean
		;;
	--clean)
		fnClean
		;;
	--clear)
		fnClean
		;;
	-n)
		fnNew "$2" "$3" "$4"
		;;
	--new)
		fnNew "$2" "$3" "$4"
		;;
	-p)
		fnPublish
		;;
	--publish)
		fnPublish
		;;
	-s)
		fnServe "$2"
		;;
	--serve)
		fnServe "$2"
		;;
	--server)
		fnServe "$2"
		;;
	-v)
		fnVersion
		;;
	--version)
		fnVersion
		;;
	*)
		fnHelpInfo
		;;
esac
exit 0