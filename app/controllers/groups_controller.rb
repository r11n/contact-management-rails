class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :update, :destroy, :toggle_status]
    def index
        render json: current_user.groups.left_joins(:contacts).select('groups.*', 'count(contacts.*)').group('groups.id').order(:id)
    end

    def show
        render json: @group
    end

    
    def create
        @group = Group.new(group_params)
        if @group.save
            render json: @group, status: :created
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    
    def update
        if @group.update(group_params)
            render json: @group
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    
    def destroy
        if @group.destroy
            render json: {message: "deleted"}, status: :ok
        else
            render json: {message: "Cannot Delete the group"}, status: :unprocessable_entity
        end
    end

    def toggle_status
        @group.status = !@group.status
        if @group.save
            render json: @group, status: :created
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    private
    def group_params
        if params[:action] == 'create'
            params[:group][:user_id] = current_user.id
            params.require(:group).permit(:name, :user_id, :is_favorite, :status) 
        else
            params.require(:group).permit(:name, :is_favorite, :status) 
        end
    end

    def set_group
        @group = Group.find_by(id: params[:id].to_i, user_id: current_user.id)
        raise ActiveRecord::RecordNotFound if !@group.present?
    end
end