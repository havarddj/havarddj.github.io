function printClassHeading(heading) {
    if (heading.level == 1) {
	return "<b>" + heading.text + "</b>";
    } else {
	return heading.text;
    };
}
