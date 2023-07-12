[1mdiff --git a/.gitignore b/.gitignore[m
[1mindex 072bcce..dcbe999 100644[m
[1m--- a/.gitignore[m
[1m+++ b/.gitignore[m
[36m@@ -38,3 +38,5 @@[m
 /yarn-error.log[m
 yarn-debug.log*[m
 .yarn-integrity[m
[32m+[m
[32m+[m[32m/.env[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/public/products_controller.rb b/app/controllers/public/products_controller.rb[m
[1mindex 4da9c5d..5c44cff 100644[m
[1m--- a/app/controllers/public/products_controller.rb[m
[1m+++ b/app/controllers/public/products_controller.rb[m
[36m@@ -28,6 +28,10 @@[m [mclass Public::ProductsController < ApplicationController[m
   def new[m
     @product = Product.new[m
     @tags = Tag.all[m
[32m+[m[32m    if params[:keyword][m
[32m+[m[32m      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])[m
[32m+[m[32m    end[m
[32m+[m[41m    [m
   end[m
 [m
   def create[m
[1mdiff --git a/app/views/public/products/_form.html.erb b/app/views/public/products/_form.html.erb[m
[1mindex 01e5b73..58c84f3 100644[m
[1m--- a/app/views/public/products/_form.html.erb[m
[1m+++ b/app/views/public/products/_form.html.erb[m
[36m@@ -8,10 +8,6 @@[m
         <th style="width: 65%"></th>[m
       </thead>[m
       <tbody>[m
[31m-        <tr class="form-group">[m
[31m-          <td><%= f.label :image, '画像' %></td>[m
[31m-          <td></td>[m
[31m-        </tr>[m
 [m
         <tr class="form-group">[m
           <td><%= f.label :name, '製品名/型式' %></td>[m
[1mdiff --git a/app/views/public/products/new.html.erb b/app/views/public/products/new.html.erb[m
[1mindex de6574e..c271b8a 100644[m
[1m--- a/app/views/public/products/new.html.erb[m
[1m+++ b/app/views/public/products/new.html.erb[m
[36m@@ -1,2 +1,57 @@[m
 <h1>Public::Products#new</h1>[m
[32m+[m[32m<hr>[m
[32m+[m[32m<hr>[m
[32m+[m
[32m+[m[32m<input type="text" id="search_area">[m
[32m+[m[32m<button type="button" id="search_button">検索</button>[m
[32m+[m[32m<ul></ul>[m
[32m+[m
[32m+[m[32m<hr>[m
[32m+[m[32m<hr>[m
[32m+[m[41m    [m
[32m+[m[32m<div class="container">[m
[32m+[m[32m<div class="row">[m[41m  [m
[32m+[m
 <%= render 'form', product: @product %>[m
[32m+[m
[32m+[m[32m  <div class="col-6 search-box">[m
[32m+[m[32m    <%= form_with url: new_product_path, method: :get, local:true do |f| %>[m
[32m+[m[32m    <div class="form-group">[m
[32m+[m[32m      <%= f.text_field :keyword, value: params[:keyword], class: "form-control" %>[m
[32m+[m[32m      <%= f.submit '製品を検索', class: "form-control btn btn-success" %>[m
[32m+[m[32m    </div>[m
[32m+[m[32m    <% end %>[m
[32m+[m[41m    [m
[32m+[m[32m    <% if @items.present? %>[m
[32m+[m[32m      <% @items.first(5).each do |item| %>[m
[32m+[m[32m      <div class="list-group">[m
[32m+[m[32m        <%= image_tag (item['mediumImageUrls'][0]), size: "100x100" %>[m
[32m+[m[32m        <%= link_to item.name, "#{item.url}" %>[m
[32m+[m[32m      </div>[m
[32m+[m[32m      <% end %>[m
[32m+[m[32m    <% end %>[m
[32m+[m[32m  </div>[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  </div>[m
[32m+[m[32m</div>[m
[32m+[m
[32m+[m
[32m+[m[32m<script>[m
[32m+[m[32m  $(function(){[m
[32m+[m[32m    $('#search_button').on('click', function(){[m
[32m+[m[32m      var keyword = $('#search_area').val();[m
[32m+[m[32m      $.get('https://app.rakuten.co.jp/services/api/IchibaItem/Search/20220601?', {[m
[32m+[m[32m        applicationID: ENV['RAKUTEN_API_KEY'],[m
[32m+[m[32m        keyword: keyword[m
[32m+[m[32m      },function(data){[m
[32m+[m[32m        if (data.count > 0){[m
[32m+[m[32m          $.each(data.Items,function(i,item){[m
[32m+[m[32m            var temp = $(`&lt;li>&lt;a href="${item.Item.itemUrl}">&lt;img src="${item.Item.mediumImageUrls[0].imageUrl}">&lt;/a>&lt;/li>`);[m
[32m+[m[32m            $('ul').append(temp);[m
[32m+[m[32m          })[m
[32m+[m[32m        }[m
[32m+[m[32m      });[m
[32m+[m[32m    });[m
[32m+[m[32m  });[m
[32m+[m[32m</script>[m
\ No newline at end of file[m
