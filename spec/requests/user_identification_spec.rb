# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Cookieによるユーザー識別", type: :request do
  it "does not create a user when only viewing pages" do
    expect { get "/" }.not_to change(User, :count)
  end

  it "creates a user on the first record and treats the same browser as the same user" do
    expect { post "/records", params: { record: { result: "done" } } }.to change(User, :count).by(1)
    expect { post "/records", params: { record: { result: "a_little" } } }.not_to change(User, :count)

    expect(Record.count).to eq(1)
    expect(Record.last.result).to eq("a_little")
  end

  it "separates data between different browsers" do
    browser_a = open_session
    browser_b = open_session

    browser_a.post "/habit", params: { habit: { name: "朝の散歩" } }
    browser_b.post "/habit", params: { habit: { name: "英単語の暗記" } }

    expect(User.count).to eq(2)

    browser_a.get "/"
    expect(browser_a.response.body).to include("朝の散歩")
    expect(browser_a.response.body).not_to include("英単語の暗記")

    browser_b.get "/"
    expect(browser_b.response.body).to include("英単語の暗記")
    expect(browser_b.response.body).not_to include("朝の散歩")
  end
end
