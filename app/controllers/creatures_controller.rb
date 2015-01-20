class CreaturesController < ApplicationController

  def index
    @creatures = Creature.all
  end

  def show
    @creature = Creature.find(params[:id])
    @tags = @creature.tags.all
    # render json: @tags
    @list = flickr.photos.search(:text => @creature.name, :sort => "relevance")
  end

  def new
    @creature = Creature.new
    @tags = Tag.all
  end

  def edit
    @creature = Creature.find(params[:id])
    @tags = Tag.all
  end

  def create
    @creature = Creature.new(creature_params)
    @tags = Tag.all
    if @creature.save
      tags = params[:creature][:tag_ids]
      tags.each do |tag_id|
        @creature.tags << Tag.find_by_id(tag_id) unless tag_id.blank?
      end
      redirect_to @creature
    else
      render :action => 'new'
    end
  end

  def update
    @creature = Creature.find(params[:id])
    @tags = Tag.all
    tags = params[:creature][:tag_ids]
    @creature.tags.clear
    tags.each do |tag_id|
      @creature.tags << Tag.find_by_id(tag_id) unless tag_id.blank?
    end
    if @creature.update(creature_params)
      redirect_to @creature
    else
      render 'edit'
    end
  end

  def destroy
    @creature = Creature.find(params[:id])
    @creature.tags.clear
    @creature.destroy


    redirect_to creatures_path
  end

  def tag_page
    @tag = Tag.find(params[:id])
    @creatures = @tag.creatures.all
  end

  private
    def creature_params
      params.require(:creature).permit(:name, :desc, :tag_ids)
    end

end