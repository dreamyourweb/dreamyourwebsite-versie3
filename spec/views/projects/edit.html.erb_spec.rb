require 'spec_helper'

describe "projects/edit.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :title => "MyString",
      :picture => "MyString",
      :description => "MyText",
      :category => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path(@project), :method => "post" do
      assert_select "input#project_title", :name => "project[title]"
      assert_select "input#project_picture", :name => "project[picture]"
      assert_select "textarea#project_description", :name => "project[description]"
      assert_select "input#project_category", :name => "project[category]"
    end
  end
end
