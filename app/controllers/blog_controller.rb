class BlogController < ApplicationController

  before_filter :tag_cloud  
  #caches_action :index, :unless => :admin?
  #cache_sweeper :post_sweeper

  def tag_cloud
  	@tags = Post.tag_counts_on(:tags)
  end

  def index
    kiss_record "View blog"
    show_draft = admin_signed_in? ?  true : false ;

  	if !params[:tag].nil?
      @posts = Post.drafts(show_draft).tagged_with(params[:tag]).page(params[:page]).per(5)
    elsif !params[:name].nil?
      @posts = Post.drafts(show_draft).includes(:associate).where(:associates => {:name => params[:name]}).page(params[:page]).per(5)
  	else
      @posts = Post.drafts(show_draft).page(params[:page]).per(5)
  	end
  	@associates = Associate.all
  end

  private

  def admin?
  	admin_signed_in?
  end
end
