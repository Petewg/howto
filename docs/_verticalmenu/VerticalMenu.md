---
layout: page
title: Vertical Menu
---

# How TO - Vertical Menu

Learn how to create a vertical menu with Harbour.

## Check method of operation.

<style>
.vertical-menu {
  font-family: "Consolas";
  width: 720px;
  height: 400px;
  background-color: #000;  
  
}

.vertical-menu a {
  background-color: #aaa; 
  color: black; 
  display: block; 
  padding: 12px; 
  text-decoration: none; 
}

.vertical-menu a:hover {
  background-color: #555; 
  color: #fff; 
}

</style>

<div class="vertical-menu">
  <a href="#">Home</a>
  <a href="#">Link 1</a>
  <a href="#">Link 2</a>
  <a href="#">Link 3</a>
  <a href="#">Link 4</a>
</div>

## Try it Yourself >>

#### [Source code](https://github.com/rjopek/howto/blob/master/src/verticalmenu/verticalmenu_01.prg)

#### Output:

![Linux]({{ site.baseurl }}/assets/img/verticalmenu_01.png "With family Linux Ubuntu desktop")

---


## Check method of operation.

Added a green color to the "active/current" link.

<style>
.vertical-menu {
  font-family: 'Consolas';
  width: 720px;
  height: 400px;
  background-color: #000;  
  
}

.vertical-menu a {
  background-color: #aaa; 
  color: black; 
  display: block; 
  padding: 12px; 
  text-decoration: none; 
}

.vertical-menu a:hover {
  background-color: #555; 
  color: #fff; 
}

.vertical-menu a.active {
  background-color: #00aa00; 
  color: #fff; 
}
</style>

<div class="vertical-menu">
  <a href="#" class="active">Home</a>
  <a href="#">Link 1</a>
  <a href="#">Link 2</a>
  <a href="#">Link 3</a>
  <a href="#">Link 4</a>
</div>

## Try it Yourself >>

#### [Source code](https://github.com/rjopek/howto/blob/master/src/verticalmenu/verticalmenu_02.prg)

#### Output:


![Linux]({{ site.baseurl }}/assets/img/verticalmenu_02.png "With family Linux Ubuntu desktop")

---

