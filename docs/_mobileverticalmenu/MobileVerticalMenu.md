---
layout: page
title: Mobile Vertical Menu
---

# How TO - Mobile Vertical Menu

Learn how to create a top navigation menu for smartphones / tablets with Harbour.

## Check method of operation

<style>

.mobile-container {
   font-family: "Consolas"; 
   width: 720px; 
   height: 440px; 
   background-color: #555; 
   color: #fff; 
}

.topnav {
   overflow: hidden; 
   background-color: #000; 
   position: relative; 
}

.topnav #myLinks {
   display: none; 
}

.topnav a {
   color: #fff; 
   padding: 14px 16px; 
   text-decoration: none; 
   display: block; 
}

.topnav a.icon {
   background: #000; 
   display: block; 
   position: absolute; 
   right: 0; 
   top: 0; 
}

.topnav a:hover {
   background-color: #aaa; 
   color: #000; 
}

.active {
   background-color: #00AA00; 
   color: #fff; 
}
</style>

<div class="mobile-container">

<div class="topnav">
   <a href="#home" class="active">Logo</a>
   <div id="myLinks">

      <a href="#news">News</a>
      <a href="#contact">Contact</a>
      <a href="#about">About</a>

   </div>
   <a href="javascript:void(0); " class="icon" onclick="myFunction()">

      <span style='font-size:16px;'>≡</span>

   </a>
</div>

<div style="padding-left:20px">
   <p>
   Vertical Mobile Navbar <br>
   This example demonstrates how a navigation menu on a <br>
   mobile/smart phone could look like.<br>
   <br>
   Click on the Trigram For Heaven menu (three bars) in the top right corner, <br>
   to toggle the menu.
   </p>
</div>

</div>

<script>
function myFunction() {
   var x = document.getElementById("myLinks"); 
   if (x.style.display === "block") {
      x.style.display = "none";
   } else {
      x.style.display = "block";
   }
}
</script>

## Try it Yourself in Harbour >>

#### [Source code](https://github.com/rjopek/howto/blob/master/src/mobileverticalmenu/vertical.prg)

#### Output:

![Linux]({{ site.baseurl }}/assets/img/vertical_01.png "With family Linux Ubuntu desktop")

