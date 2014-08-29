class SubsController < ApplicationController
  before_action :ensure_moderated, only: [:destroy, :edit, :update]
  before_action :ensure_logged_in, except: [:index, :show]

  def index
    @subs = Sub.all.order(:title)
  end

  def new
    @sub = current_user.moderated_subs.new
  end
  
  def create
    @sub = current_user.moderated_subs.new(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def show
    current_sub
  end
  
  def edit
    current_sub
  end
  
  def update
    if current_sub.update(sub_params)
      redirect_to sub_url(current_sub)
    else
      flash.now[:errors] = current_sub.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    current_sub.destroy
    
    redirect_to subs_url
  end
  
  private
  
  def ensure_moderated
    unless current_sub.moderator == current_user
      flash[:errors] = ["You are not the moderator for #{ current_sub.title }."]
      redirect_to sub_url(current_sub)
    end
  end
  
  def current_sub
    @sub ||= Sub.find(params[:id])
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
