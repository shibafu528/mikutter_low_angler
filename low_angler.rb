# frozen_string_literal: true

require 'panchira'

Plugin.create(:low_angler) do
  ::Panchira::Extensions.resolvers.each do |resolver|
    next if resolver == ::Panchira::ImageResolver

    notice "[low_angler] Register #{resolver}"

    resolve_cache = Hash.new

    defimageopener(resolver.name, resolver.method(:applicable?)) do |url|
      resolve_cache[url] ||= resolver.new(url).fetch.image.url
      URI.open(resolve_cache[url])
    end
  end
end
