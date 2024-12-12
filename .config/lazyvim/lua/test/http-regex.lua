-- lua dofile(vim.fn.expand('%'))
local pattern = "https?://[%w-_%.%?%.:/%+=&#]+"

local urls = {
  "https://www.example.com",
  "http://example.org/path/to/page.html?query=value#anchor",
  "https://subdomain.example.net/some/path/",
  "http://user:pass@example.com/login", -- TODO: this fails
  "https://www.example.com/search?q=lua+regex",
  "https://github.com/hrsh7th/vim-vsnip/blob/master/plugin/vsnip.vim#L65C1-L74C12",
}

for _, url in ipairs(urls) do
  local detected = url:match(pattern)
  if detected == url then
    print("Match Correct: " .. detected)
  else
    print("Incorrect: " .. detected)
    print("   origin: " .. url)
  end
end
