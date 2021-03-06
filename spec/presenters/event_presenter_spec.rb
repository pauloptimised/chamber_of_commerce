require 'rails_helper'

RSpec.describe EventPresenter, type: :presenter do
  let(:event) { build(:event) }
  subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }

  describe "event accessing model attributes" do
    it "returns id" do
      expect(event_presenter.id).to eq(event.id)
    end

    it "returns the name" do
      expect(event_presenter.name).to eq(event.name)
    end
  end

  describe "event booking button" do
    describe "standard event" do
      let(:event) { create(:event) }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }
      it "should link to the event booking path" do
        book_button = link_to "Book now", new_event_event_booking_path(event), id: "book-event", class: "button"
        allow(event_presenter).to receive(:display_booking_button?).and_return(true)
        expect(event_presenter.booking_button).to eq(book_button)
      end
    end

    describe "has eventbrite link" do
      let(:event) { create(:event, eventbrite_link: "http://www.google.co.uk/") }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }
      it "should have a booking button that links to eventbrite" do
        book_button = link_to "Book now", event.eventbrite_link, id: "book-event", class: "button"
        allow(event_presenter).to receive(:display_booking_button?).and_return(true)
        expect(event_presenter.booking_button).to eq(book_button)
      end
    end

    describe "set not to be bookable" do
      let(:event) { build(:event, allow_booking: false) }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }
      it "should not have a booking button" do
        expect(event_presenter.booking_button).to be nil
      end
    end
  end

  describe "event dates" do
    describe "start date and end date" do
      let(:event) { build(:event) }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }

      it "should display start and end dates" do
        content = "Start <strong>#{ l event.start_date, format: :long }</strong> End <strong>#{ l event.end_date, format: :long }</strong>"
        expect(event_presenter.dates).to eq(content)
      end

      it "return nil for the booking deadline" do
        expect(event_presenter.booking_deadline).to eq(nil)
      end
    end

    describe "no end date" do
      let(:event) { build(:event, end_date: nil) }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }
      it "should simply display the start date" do
        content = "<strong>#{ l event.start_date, format: :long }</strong>"
        expect(event_presenter.dates).to eq(content)
      end
    end

    describe "date formatting" do
      let(:event) { build(:event, booking_deadline: Date.tomorrow) }
      subject(:event_presenter) { EventPresenter.new(object: event, view_template: view) }

      it "should return the booking deadline date with default format" do
        expect(event_presenter.booking_deadline).to eq(l event.booking_deadline, format: :default)
      end

      it "should return the booking deadline date with short format" do
        expect(event_presenter.booking_deadline(:short)).to eq(l event.booking_deadline, format: :short)
      end

      it "should return the booking deadline date with long format" do
        expect(event_presenter.booking_deadline(:long)).to eq(l event.booking_deadline, format: :long)
      end
    end
  end





end
