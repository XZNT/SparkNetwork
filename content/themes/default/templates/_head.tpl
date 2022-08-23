<!doctype html>

<html lang="{$system['language']['code']}" {if $system['language']['dir'] == "RTL"} dir="RTL" {/if}>

  <head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="generator" content="Spark">
    <meta name="version" content="{$system['system_version']}">

    <!-- Title -->
    <title>{$page_title|truncate:70}</title>
    <!-- Title -->

    <!-- Meta -->
    <meta name="description" content="{$page_description|truncate:300}">
    <meta name="keywords" content="{$system['system_keywords']}">
    <!-- Meta -->

    <!-- OG-Meta -->
    <meta property="og:title" content="{$page_title|truncate:70}" />
    <meta property="og:description" content="{$page_description|truncate:300}" />
    <meta property="og:site_name" content="{__($system['system_title'])}" />
    <meta property="og:image" content="{$page_image}" />
    <!-- OG-Meta -->

    <!-- Twitter-Meta -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{$page_title|truncate:70}" />
    <meta name="twitter:description" content="{$page_description|truncate:300}" />
    <meta name="twitter:image" content="{$page_image}" />
    <!-- Twitter-Meta -->

    <!-- Favicon -->
    {if $system['system_favicon_default']}
      <link rel="shortcut icon" href="{$system['system_url']}/content/themes/{$system['theme']}/images/favicon.png" />
    {elseif $system['system_favicon']}
      <link rel="shortcut icon" href="{$system['system_uploads']}/{$system['system_favicon']}" />
    {/if}
    <!-- Favicon -->

    <!-- Fonts [Poppins|Roboto|Font-Awesome] -->
    {if $system['language']['dir'] == "LTR"}
      <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" crossorigin="anonymous" />
    {else}
      <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" crossorigin="anonymous" />
    {/if}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Fonts [Poppins|Roboto|Font-Awesome] -->

    <!-- CSS -->
    {if $system['language']['dir'] == "LTR"}
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
      <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.min.css">
    {else}
      <link rel="stylesheet" href="https://cdn.rtlcss.com/bootstrap/v4.5.3/css/bootstrap.min.css" integrity="sha384-JvExCACAZcHNJEc7156QaHXTnQL3hQBixvj5RV5buE7vgnNEzzskDtx9NQ4p6BJe" crossorigin="anonymous">
      <link rel="stylesheet" type='text/css' href="{$system['system_url']}/content/themes/{$system['theme']}/css/style.rtl.min.css">
    {/if}
    <!-- CSS -->

    <!-- CSS Customized -->
    {include file='_head.css.tpl'}
    <!-- CSS Customized -->

    <!-- Header Custom JavaScript -->
    {if $system['custome_js_header']}
      <script>
        {html_entity_decode($system['custome_js_header'], ENT_QUOTES)}
      </script>
    {/if}
    <!-- Header Custom JavaScript -->

</head>