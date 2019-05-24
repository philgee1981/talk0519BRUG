## Wordpress via curl - a primer
- RWordpress is nice, but has its limitations regarding images and custom post types
- As always [RTFM](https://developer.wordpress.org/rest-api/) is a great advice
- For Access, you need a token. 
- This token can be made @http://url_to_your.blog/wp-admin/profile.php:
![alt text](/Application_pwd.png "")

- Publishing a post: curl --header 'Authorization: Basic Your_token_here' -X POST -d 'title=title' -d 'status=publish' -d 'content=content' -d 'featured_media=post_picture_id' -d 'author=autor_id' -d 'slug=permalink-structure' -d 'excerpt=some excerpt' https://url_to_your.blog/wp-json/wp/v2/post_type
- Uploading media: curl --request POST --url https://url_to_your.blog/wp-json/wp/v2/media --header 'authorization: Basic Your_token_here' --header 'content-disposition: attachment; filename=picture.png; ' --header 'content-type: image/png' --data-binary '@path/to/picture.png'