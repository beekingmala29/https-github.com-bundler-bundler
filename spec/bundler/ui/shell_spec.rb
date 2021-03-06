# frozen_string_literal: true
require "spec_helper"

RSpec.describe Bundler::UI::Shell do
  subject { described_class.new }

  before { subject.level = "debug" }

  describe "#info" do
    before { subject.level = "info" }
    it "prints to stdout" do
      expect { subject.info("info") }.to output("info\n").to_stdout
    end
  end

  describe "#confirm" do
    before { subject.level = "confirm" }
    it "prints to stdout" do
      expect { subject.confirm("confirm") }.to output("confirm\n").to_stdout
    end
  end

  describe "#warn" do
    before { subject.level = "warn" }
    it "prints to stdout" do
      expect { subject.warn("warning") }.to output("warning\n").to_stdout
    end
  end

  describe "#debug" do
    it "prints to stdout" do
      expect { subject.debug("debug") }.to output("debug\n").to_stdout
    end
  end

  describe "#error" do
    before { subject.level = "error" }
    it "prints to stdout" do
      expect { subject.error("error!!!") }.to output("error!!!\n").to_stdout
    end

    context "when stderr flag is enabled" do
      before { Bundler.settings.temporary(:error_on_stderr => true) }
      it "prints to stderr" do
        expect { subject.error("error!!!") }.to output("error!!!\n").to_stderr
      end
    end
  end
end
