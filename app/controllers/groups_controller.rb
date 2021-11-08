class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]


  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = current_user.owned_groups.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "You have created group successfully."
      redirect_to groups_path
    else
      render :new
    end
  end

  def index
    @groups = Group.all
    @user = current_user
    @newbook = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @user = current_user
    @newbook = Book.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path notice: "You have updated group successfully."
    else
      render "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_image, :introduction, :name, user_ids:[] )
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
