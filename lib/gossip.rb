require 'bundler'
require 'csv'
Bundler.require

require_relative './controller'

# a gossip
class Gossip

  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.find(id)
    read = CSV.read('db/gossip.csv')
    read[id.to_i]
  end

  def self.update(id, author, message)
    read = CSV.read('db/gossip.csv')
    read.delete_at(id.to_i)
    read.insert(id.to_i, [author, message])
    CSV.open('db/gossip.csv', 'w') do |csv|
      read.each do |line|
        csv << line
      end
    end
  end

  def self.comment(id, comm)
    CSV.open('db/comments.csv', 'ab') do |comment|
      comment << [id, comm]
    end
  end

  def self.find_comm(id)
    read = CSV.read('db/comments.csv')
    read.keep_if { |c| c[0] == id }
  end

  def self.destroy(index)
    read = CSV.read('db/gossip.csv')
    read.delete_at(index)
    CSV.open('db/gossip.csv', 'w') do |csv|
      read.each do |line|
        csv << line
      end
    end
  end

  def self.all
    all_gossips = []
    CSV.read('db/gossip.csv').each do |line|
      temp_gossip = Gossip.new(line[0], line[1])
      all_gossips << temp_gossip
    end
    all_gossips
  end
end
