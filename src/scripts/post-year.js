function postYear (post) {
  return Date.parse(post.frontmatter.pubDate).getYear();
}
