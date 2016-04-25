class NotesController < ApplicationController
  before_action :find_note, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @notes = Note.where(user_id: current_user).order("created_at DESC")
  end

  def show
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:notice] = "Noted!"
      redirect_to @note
    else
      flash[:notice] = "Title and Note required!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      respond_with @note
    else
      render 'edit'
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = "Note Deleted, Bye Bye Note!"
    redirect_to notes_path
  end

  private

  def find_note
    @note = Note.find(params[:id])
  end

	def note_params
		params.require(:note).permit(:title, :content)
	end

end
