class HistoryTracker
  include Mongoid::History::Tracker
  include Mongoid::Userstamps
end
