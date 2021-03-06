require "./test/helper"

prepare do
  redis.flushdb
  redis.hmset("versions", "stable", "2.0.4", "development", "2.1.9")
end

scope do
  test "Sitemap" do
    visit "/"

    click_link_or_button "Commands"

    assert has_content?("PING")

    click_link_or_button "Clients"

    assert has_content?("redis-rb")

    click_link_or_button "Download"

    assert has_content?("Run Redis with:")

    click_link_or_button "Community"

    assert has_css?("a[href='http://groups.google.com/group/redis-db']", text: "mailing list")
    assert has_content?("#redis")
    assert has_css?("a[href='http://twitter.com/antirez']", text: "Salvatore")

    click_link_or_button "Documentation"

    click_link_or_button "full list of commands"

    assert has_content?("PING")
  end
end
