class Api::V1::EntriesController < ApplicationController
  before_action :entry, only: [:show, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all

    render json: @entries
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    render json: @entry
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    if @entry.update(entry_params)
      head :no_content
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy

    head :no_content
  end

  private

    def entry
      @entry ||= Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:line, :order)
    end
end
