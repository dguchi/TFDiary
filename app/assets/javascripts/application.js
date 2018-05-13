// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require nested_form_fields
/* global $ */

console.log("javascript read");

function OnClickRegistMenu(menu_id) {
    var target = document.getElementById("menu-regist-button");

    if ("メニュー登録" == target.innerText)
    {
        target.className = "deregist";
        target.textContent = "登録解除";
        $.ajax({
            url: '/users/follow_menu',
            type: 'GET',
            dataType: 'json',
            async: true,
            data: {menu_id: menu_id},
        });
    }
    else
    {
        target.className = "regist";
        target.textContent = "メニュー登録";
        $.ajax({
            url: '/users/unfollow_menu',
            type: 'GET',
            dataType: 'json',
            async: true,
            data: {menu_id: menu_id},
        });
    }
}

function OnClickFollowUser(user_id) {
    var target = document.getElementById("user-follow-button");

    if ("フォロー" == target.innerText)
    {
        target.className = "unfollow";
        target.textContent = "フォロー解除";
        $.ajax({
            url: '/users/follow_user',
            type: 'GET',
            dataType: 'json',
            async: true,
            data: {user_id: user_id},
        });
    }
    else
    {
        target.className = "follow";
        target.textContent = "フォロー";
        $.ajax({
            url: '/users/unfollow_user',
            type: 'GET',
            dataType: 'json',
            async: true,
            data: {user_id: user_id},
        });
    }
}

// メニュー追加ボタンクリック時の処理
function OnClickAddMenuButton() {
    $('#add-menu-popup-layer, #add-menu-popup').show();
}

// レイヤー/ポップアップの閉じるボタンクリック時の処理
function OnClickCloseAddMenuButton() {
    $('#add-menu-popup-layer, #add-menu-popup').hide();
}

function SubmitAction(url) {
  $('form').attr('action', url);
  $('form').submit();
}
