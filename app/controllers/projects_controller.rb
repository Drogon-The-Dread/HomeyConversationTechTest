# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def status_transition
    @project = Project.find(params[:id])

    return head(:forbidden) unless @project.owner == current_user
    return head(:bad_request) unless @project.status_transitions.map(&:event).include?(params[:event].to_sym)

    if @project.send("#{params[:event]}!")
      redirect_to @project, notice: 'Project status was successfully updated.'
    else
      redirect_to @project, alert: 'Project status could not be updated.'
    end
  end

  def show
    @project = Project.find(params[:id])

    @is_owner = @project.owner == current_user
    @available_transition_events = @project.status_transitions.map(&:event)
  end

  def create_user_comment
    Rails.logger.debug("Event: #{event}")
    Rails.logger.debug("Current State: #{@project.status}")
    Rails.logger.debug("Available Transitions: #{@project.state_machine.events.map(&:name)}")

    @project = Project.find(params[:project_id])
    event = params[:project_history_item][:event]&.downcase

    # Add the user's comment
    @project.add_user_comment(current_user, params[:project_history_item][:content])

    # Check if a status change event was selected
    if event.present? && @project.state_machine.events.map(&:name).include?(event)
      # Perform the status transition
      if @project.send("#{event}!")
        redirect_to @project, notice: 'Comment added and status successfully updated.'
      else
        redirect_to @project, alert: 'Comment added, but status could not be updated.'
      end
    else
      redirect_to @project, notice: 'Comment added successfully.'
    end
  end

  private

  def project_params
    params.require(:project).permit(:status)
  end
end
