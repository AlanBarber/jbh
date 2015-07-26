#(JBH) Jekyll Blog Helper - A bash shell script to help manage a jekyll weblog site

#Change Log

## Version 1.2.1

 * Fixed a bug in --publish for rsync not using correct site path

## Version 1.2.0

 * Added --list command. Lets you get a raw view of posts and drafts. Includes optional filter.
 * Added --move command. Lets you move drafts to post and posts to draft folder.
 * Changed asset folder so that if set to "" in config it will disable creation of asset folder and not add ref link to bottom of post

## Version 1.1.0

 * Added paths to config options at the top
 * Found a bug in the --new command
 * Added version info to script for better tracking of bug reports

## Version 1.0.0

Initial release to public
