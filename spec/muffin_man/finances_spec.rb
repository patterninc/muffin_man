RSpec.describe MuffinMan::Finances::V0 do
  before do
    stub_request_access_token
    stub_list_financial_event_groups
    stub_list_financial_event_by_group_id
  end

  let(:max_results_per_page) { 10 }
  let(:financial_event_group_started_before) { Time.now - 3600 }
  let(:financial_event_group_started_after) { Time.now  }
  let(:posted_before) { Time.now - 3600 }
  let(:posted_after) { Time.now  }
  let(:event_group_id) { "Event_ID" }

  subject(:finances_client) { described_class.new(credentials) }

  describe "list financial event groups" do
    it "makes a get request to list financial event groups" do
      expect(finances_client.list_financial_event_groups(max_results_per_page, financial_event_group_started_before,
                                                         financial_event_group_started_after).response_code).to eq(200)
    end
  end

  describe "list financial events by group Id" do
    it "makes a get request to list financial event by group Id" do
      expect(finances_client.list_financial_events_by_group_id(event_group_id, max_results_per_page, posted_after,
                                                               posted_before).response_code).to eq(200)
    end
  end
end
