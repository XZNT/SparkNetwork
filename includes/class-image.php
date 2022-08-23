<?php
class Image
{

  public $_img;
  public $_img_ext;
  public $_img_type;
  public $_img_width;
  public $_img_height;

  /**
   * __construct
   * 
   * @param string $file
   */
  public function __construct($file)
  {
    /* check for the required GD extension */
    if (extension_loaded('gd')) {
      /* ignore JPEG warnings that cause imagecreatefromjpeg() to fail */
      ini_set('gd.jpeg_ignore_warning', 1);
    } else {
      throw new Exception(__("Required extension GD is not loaded"));
    }
    $img_info = @getimagesize($file);
    if (!$img_info) {
      throw new Exception(__("The file type is not valid image"));
    }
    $this->_img_type = $img_info['mime'];
    $this->_img_width = $img_info[0];
    $this->_img_height = $img_info[1];
    switch ($this->_img_type) {
      case 'image/jpeg':
      case 'image/jpg':
        $this->_img = imagecreatefromjpeg($file);
        if (!$this->_img) {
          throw new Exception(__("The file type is not valid image"));
        }
        /* fix orientation */
        if (function_exists('exif_read_data')) {
          $exif = exif_read_data($file);
          if ($exif && isset($exif['Orientation'])) {
            $ort = $exif['Orientation'];
            if ($ort == 6 || $ort == 5)
              $this->_img = imagerotate($this->_img, 270, null);
            if ($ort == 3 || $ort == 4)
              $this->_img = imagerotate($this->_img, 180, null);
            if ($ort == 8 || $ort == 7)
              $this->_img = imagerotate($this->_img, 90, null);
            if ($ort == 5 || $ort == 4 || $ort == 7)
              imageflip($this->_img, IMG_FLIP_HORIZONTAL);
          }
        }
        $this->_img_ext = '.jpg';
        break;

      case 'image/png':
        $this->_img = imagecreatefrompng($file);
        if (!$this->_img) {
          throw new Exception(__("The file type is not valid image"));
        }
        $this->_img_ext = '.png';
        break;

      case 'image/gif':
        $this->_img = imagecreatefromgif($file);
        if (!$this->_img) {
          throw new Exception(__("The file type is not valid image"));
        }
        $this->_img_ext = '.gif';
        break;

      case 'image/webp':
        $this->_img = ($this->isWebpAnimated($file)) ? $file : imagecreatefromwebp($file);
        if (!$this->_img) {
          throw new Exception(__("The file type is not valid image"));
        }
        $this->_img_ext = '.webp';
        break;

      case 'image/bmp':
      case 'image/x-ms-bmp':
      case 'image/x-windows-bmp':
        $this->_img = imagecreatefrombmp($file);
        if (!$this->_img) {
          throw new Exception(__("The file type is not valid image"));
        }
        $this->_img_ext = '.bmp';
        break;

      default:
        throw new Exception(__("The file type is not valid image"));
        break;
    }
  }


  /**
   * getWidth
   * 
   * @return integer
   */
  public function getWidth()
  {
    return imagesx($this->_img);
  }


  /**
   * getHeight
   * 
   * @return integer
   */
  public function getHeight()
  {
    return imagesy($this->_img);
  }


  /**
   * crop
   * 
   * @param integer $width
   * @param integer $height
   * @param integer $x
   * @param integer $y
   */
  public function crop($width, $height, $x, $y)
  {
    $new_image = imagecreatetruecolor($width, $height);
    imagecopy($new_image, $this->_img, 0, 0, $x, $y, $width, $height);
    $this->_img = $new_image;
  }


  /**
   * resize
   * 
   * @param integer $width
   * @param integer $height
   */
  public function resize($width, $height)
  {
    $new_image = imagecreatetruecolor($width, $height);
    imagecopyresampled($new_image, $this->_img, 0, 0, 0, 0, $width, $height, $this->getWidth(), $this->getHeight());
    $this->_img = $new_image;
  }


  /**
   * resizeWidth
   * 
   * @param integer $width
   */
  public function resizeWidth($width)
  {
    $ratio = $width / $this->getWidth();
    $height = $this->getHeight() * $ratio;
    $this->resize($width, $height);
  }


  /**
   * resizeHeight
   * 
   * @param integer $height
   * @return void
   */
  public function resizeHeight($height)
  {
    $ratio = $height / $this->getHeight();
    $width = $this->getWidth() * $ratio;
    $this->resize($width, $height);
  }


  /**
   * isWebpAnimated
   * 
   * @param integer $src
   * @return boolean
   */
  public function isWebpAnimated($src)
  {
    $webpContents = file_get_contents($src);
    $where = strpos($webpContents, "ANMF");
    if ($where !== FALSE) {
      return true;
    } else {
      return false;
    }
  }


  /**
   * save
   * 
   * @param string $path
   * @param string $quality
   * @return void
   */
  public function save($path, $quality = 'medium')
  {
    switch ($quality) {
      case 'high':
        $quality = 100;
        $compression = 1;
        break;

      case 'low':
        $quality = 10;
        $compression = 9;
        break;

      default:
        /* default PHP */
        $quality = 75;
        $compression = 6;
        break;
    }
    switch ($this->_img_type) {
      case 'image/jpeg':
      case 'image/jpg':
        imagejpeg($this->_img, $path, $quality);
        break;

      case 'image/png':
        imagealphablending($this->_img, false);
        imagesavealpha($this->_img, true);
        imagepng($this->_img, $path, $compression);
        break;

      case 'image/gif':
        imagegif($this->_img, $path);
        break;

      case 'image/webp':
        imagewebp($this->_img, $path);
        break;
    }
  }
}
