class HomeController < ApplicationController
	manageable_content_for :body, :title, :dreamteam, :layout => "home_layout"
	layout "home_layout"

  def mobile_agent?
    request.user_agent =~ /Mobile|webOS/
    #false
  end
  
  def parse_boolean(value)    
     [true, 'true', 1, '1', 't'].include?(value.respond_to?(:downcase) ? value.downcase : value)  
  end 

  def mobile?
    case
    when !params[:mobile].nil?
      parse_boolean(params[:mobile])
    when !session[:mobile].nil?
      session[:mobile]
    else
      mobile_agent?
    end 
  end

  def index
		@ref = params[:ref]
    if mobile?
      redirect_to mobile_path
    end
    @posts = Post.last(2)
    @project = Project.last
    @lasttweet = Twitter.user_timeline("invite2eat").first.text
    @lasttweet = @lasttweet.strip.gsub(/(#\w+)/) {|s| '<a href=http://twitter.com/#!/search?q=%23' + s.gsub(/#/,"") + '>' + s + '</a>'}
    @lasttweet = @lasttweet.strip.gsub(/(@\w+)/) {|s| '<a href=http://twitter.com/#!/' + s.gsub(/@/,"") + '>' + s + '</a>'}
    @lasttweet = @lasttweet.html_safe
  end

  def full
    session[:mobile] = false
    redirect_to root_path
  end

end
