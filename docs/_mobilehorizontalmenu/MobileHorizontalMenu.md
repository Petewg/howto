---
layout: page
title: Mobile Horizontal Menu
---

# How TO - Mobile Horizontal Menu

Learn how to create a top navigation menu for smartphones / tablets with Harbour.

## Check method of operation

<style>

.mobile-container {
   font-family: "Consolas"; 
   width: 720px; 
   height: 440px; 
   background-color: #555; 
   color: #fff; }

.topnav {
   overflow: hidden; 
   background-color: #000; 
   position: relative; 
}

.topnav #myLinks {
   display: none; 
}

.topnav a {
   float: left; 
   color: #fff; 
   padding: 14px 16px; 
   text-decoration: none; 
 }

.topnav a.icon {
   float: right; 
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

<div style="padding-left:16px">
   <p>Horizontal Mobile Navbar <br>
   This example demonstrates how a navigation menu on a mobile/smart <br>
   phone could look like. <br>
   <br>
   Click on the hamburger menu (three bars) in the top right corner, <br>
   to toggle the menu.<br>
   <br>
   Note that this example should'nt be used if you have a lot of links, <br>
   as they will "break" the navbar when there's too many <br>
   (especially on very small screens).
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

#### [Source code](https://github.com/rjopek/howto/blob/master/src/mobilehorizontalmenu/horizontal.prg)

#### Output:

![Linux]({{ site.baseurl }}/assets/img/horizontal_01.png "With family Linux Ubuntu desktop")

