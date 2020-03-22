// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


$(document).on('turbolinks:load', function () {
    var postModel = document.getElementById("create-post-model");
    var btnNewPost = document.getElementById("box-btn-new-post").firstElementChild;
    var btnCancel = document.getElementById('cancel-btn');
    btnNewPost.onclick = function () {
        postModel.style.display = "block";
    };
    btnCancel.onclick = function (e) {
        postModel.style.display = "none";
    };

    var createPostBtn = document.getElementById('create-post-btn');
    var boxNewPostBtn = document.getElementById('box-btn-new-post');
    var postTitle = document.getElementById('post-title');
    var postBody = document.getElementById('post-body');
    var postList = document.getElementById('posts');

    createPostBtn.onclick = function (e) {
        var postTitleContent = $(postTitle).val();
        var postBodyContent = $(postBody).val();
        var postData = {
            post: {
                title: postTitleContent,
                body: postBodyContent
            }
        };

        $.ajax({
            type: "post",
            url: "/posts",
            dataType: 'json',
            data: postData,
        }).done(function (response) {
            alert("Post was " + response.post_status);
            postModel.style.display = "none";
            var newPostComponent = getPostHtml(response.post_id, response.created_at, postTitleContent, postBodyContent);
            newPostComponent.insertAfter(boxNewPostBtn);
        }).fail(function (jqXHR, textStatus, errorThrown) {
            alert("fail")
        })
    }

});

function getPostHtml(post_id, created_at, title, body) {
    var html_string = `<div class='box-post'><p><strong class='post-title'><a href='/posts/${post_id}'>${title}</a></strong>` +
        "<small class='edit-text'>edit</small></p>" +
        `<small class='created-time'>${created_at}</small>` +
        `<p><i class='post-body'>${body}</i></p></div>`;
    return $(html_string)
}
