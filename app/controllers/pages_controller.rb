class PagesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:gallery,:about]
  before_action :find_feature, only:[:admin,:index]
  before_action :find_blog, only:[:admin,:index,:adminblog]
  before_action :find_watercolor, only:[:admin,:index,:adminwt]
  before_action :find_about, only:[:admin,:index,:about,:adminabout]
  before_action :find_user,except: [:about]
  before_action :find_setting, only:[:adminsetting, :index,:about,:admin]
  before_action :find_gallery, only:[:admingallery,:adminfeature,:adminblog,:adminwt,:adminabout]
  def index
    
    @homepage = true
  end

  def gallery

  end

  def upload
    puts params.to_json
   
    image = @user.images.attach(params[:images])
    redirect_to '/admin/gallery'
  end

  def about
  
  end

  def admin
    
    @page = 'home'
  end
   # render gallery 
  def admingallery

    @page = 'gallery'
  end
   # render gallery specific photo
  def adminphoto

    @image = @user.images.find(params[:id])
    @page = 'gallery'
  end
  #delete image gallery
  
  def imgdelete
    if !About.exists?(:about_img => params[:id]) && !Watercolor.exists?(:imageid => params[:id]) && !Feature.exists?(:img_detail => params[:id]) &&  !Blog.exists?(:blog_img => params[:id])
    @user.images.find(params[:id]).purge
    redirect_to '/admin/gallery' 
    else
      redirect_to "/admin/gallery/#{params[:id]}",flash: { error: "Unable to delete photo because this photo is currently using on the homepage, you have to replace it with another image before deleting" }
   
    end
  end
     # for edit feature section photos
  def adminfeature
    @page = 'home'
    img = Feature.find(params[:id])
    @image = @user.images.find(img.img_detail)
    @featureId = img.id
 
  end

     # for edit blog content and photos
  def adminblog
    @page = 'home'
    @id = Integer(params[:id])
    @blogitem = @blogitems[@id]

  
  end
 
  def adminwt
    @page = 'home'
    @id = Integer(params[:id])
    @wtitem = @wtitems[@id]
  end

  def adminabout
    @page = 'home'
    @aboutitem = @about[1]
  
  end

  def adminsetting
    @page = 'setting'

  end

  def featureupdate
    @featureImg = Feature.find(params[:featureId])
    if params[:imageId].present?
    @featureImg.update(:img_detail => params[:imageId])
    redirect_to '/admin/'
    else
      redirect_to '/admin/feature/' + params[:featureId]
    end
  end

  def blogupdate
    @blog = Blog.find(params[:blogId])
    if params[:imgId].present?
    @blog.update(:title => params[:title], :body => params[:body], :blog_img => params[:imgId])
    redirect_to '/admin/'
    else
      redirect_to '/admin/blog/' + params[:blogId]
    end
    puts params
  end

  def wtupdate
    puts params
    if params[:imageId].present?
    @wt = Watercolor.find(params[:wtId])
    @wt.update(:imageid => params[:imageId])
    redirect_to '/admin'
    else 
      redirect_to '/admin/wt/' + params[:wtId]
    end
  
  end

  def aboutupdate 
    if params[:imgId].present?
      @about = About.find(1)
      @about.update(:about_img => params[:imgId], :intro => params[:intro], :intro_body => params[:intro_body],:subintro => params[:subintro], :subintro_body => params[:subintro_body])
      redirect_to '/admin'
    else
    redirect_to '/admin/about'
    end
  end
  def settingupdate
    @setting = Setting.find(2)
    @setting.update(:s1 => params[:s1], :s2 => params[:s2], :s3 => params[:s3], :s4 => params[:s4])
    redirect_to '/admin'
  end



  def find_feature 
    # Create a map with key is feature id and value is active storage image
    @user = User.find(1)
    @features = {}
    @imgids = Feature.all.order(:id)
    puts @imgids.to_json
    @imgids.each do |item|
      @features[item.id] = @user.images.find(item.img_detail)
    end
 
    return @features
    
  end
  def find_user
    return @user = User.find(1)
  end

  def find_blog
       # Create a map with key is blog_id id and value is blog itself and img storage
    @blogitems = {}
    @user = User.find(1)
    @blogs = Blog.all.order(:id)
    @blogs.each do |b|
      @blogitems[b.id] = {title: b.title, body: b.body, blog_img:@user.images.find(b.blog_img) }
    end
    return @blogitems

  end                   

  def find_gallery 
    @gallery = @user.images
  end


  def find_watercolor
    @wtitems = {}
    @user = User.find(1)
    @watercolors = Watercolor.all.order(:id)
    @watercolors.each do |wt|
      @wtitems[wt.id] = @user.images.find(wt.imageid)
    end
    puts @wtitems
    
  end

  def find_about
    @about = {}
    @aboutitem = About.find(1)
    @user = User.find(1)
    @about[@aboutitem.id] = {
      about_img: @user.images.find(@aboutitem.about_img),
      intro:@aboutitem.intro,
      intro_body:@aboutitem.intro_body,
      subintro:@aboutitem.subintro,
      subintro_body:@aboutitem.subintro_body
    }
    return @about
  end
  def find_setting
    @setting = Setting.last
  end
end
