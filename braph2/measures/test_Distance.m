%TEST_DISTANCE

%% Test 1: Inspection Methods
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	categories = num2cell(Category.getCategories());
	m = Distance();
	 
	% get('ELCLASS')
	if isa(Distance, 'ConcreteElement')
		assert(strcmp(Distance().get('ELCLASS'), 'Distance'), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance().get(''ELCLASS'') should return ''Distance''.')
	end
	 
	% getBuild()
	assert(Distance.getBuild() == 1 && Distance.getBuild() > 0, ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getBuild() should return the Distance build number.')
	assert(m.getBuild() == 1 && m.getBuild() > 0 , ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getBuild() should return the Distance build number.')
	assert(Element.getBuild(m) == 1 && Element.getBuild(m) > 0, ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getBuild(m) should return the Distance build number.')
	assert(Element.getBuild('Distance') == 1 && Element.getBuild('Distance') > 0, ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getBuild(''Distance'') should return the Distance build number.')
	 
	% getClass()
	assert(strcmp(Distance.getClass(), 'Distance'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getClass() should return ''Distance''.')
	assert(strcmp(m.getClass(), 'Distance'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getClass() should return ''Distance''.')
	assert(strcmp(Element.getClass(m), 'Distance'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getClass(m) should return ''Distance''.')
	assert(strcmp(Element.getClass('Distance'), 'Distance'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getClass(''Distance'') should return ''Distance''.')
	 
	% getSubclasses()
	assert(isequal(Distance.getSubclasses(), subclasses('Distance', [], [], true)), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getSubclasses() should return the same result as subclasses(''Distance'', [], [], true).')
	assert(isequal(m.getSubclasses(), subclasses('Distance', [], [], true)), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'el.getSubclasses() should return the same result as subclasses(''Distance'', [], [], true).')
	assert(isequal(Element.getSubclasses(m), subclasses('Distance', [], [], true)), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getSubclasses(m) should return the same result as subclasses(''Distance'', [], [], true).')
	assert(isequal(Element.getSubclasses('Distance'), subclasses('Distance', [], [], true)), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getSubclasses(''Distance'') should return the same result as subclasses(''Distance'', [], [], true).')
	 
	% getProps()
	assert(isempty(Distance.getProps()) || isequal(Distance.getProps(), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getProps() should return a row vector [1:1:N].')
	assert(isempty(Distance.getProps()) || isequal(m.getProps(), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getProps() should return a row vector [1:1:N].')
	assert(isempty(Distance.getProps()) || isequal(Element.getProps(m), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getProps(m) should return a row vector [1:1:N].')
	assert(isempty(Distance.getProps()) || isequal(Element.getProps('Distance'), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getProps(''Distance'') should return a row vector [1:1:N].')
	 
	% getProps(category)
	tmp = cellfun(@(category) Distance.getProps(category), categories, 'UniformOutput', false);
	assert(isempty(Distance.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getProps(category) does not work.')
	tmp = cellfun(@(category) m.getProps(category), categories, 'UniformOutput', false);
	assert(isempty(Distance.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getProps(category) does not work.')
	tmp = cellfun(@(category) Element.getProps(m, category), categories, 'UniformOutput', false);
	assert(isempty(Distance.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getProps(m, category) does not work.')
	tmp = cellfun(@(category) Element.getProps('Distance', category), categories, 'UniformOutput', false);
	assert(isempty(Distance.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(Distance.getProps())), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getProps(''Distance'', category) does not work.')
	 
	% getPropNumber()
	assert(Distance.getPropNumber() == length(Distance.getProps()), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getPropNumber() should return the number of properties.')
	assert(m.getPropNumber() == length(Distance.getProps()), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getPropNumber() should return the number of properties.')
	assert(Element.getPropNumber(m) == length(Distance.getProps()), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getPropNumber(m) should return the number of properties.')
	assert(Element.getPropNumber('Distance') == length(Distance.getProps()), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getPropNumber(''Distance'') should return the number of properties.')
	 
	% getPropNumber(category)
	assert(sum(cellfun(@(category) Distance.getPropNumber(category), categories)) == Distance.getPropNumber(), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.getPropNumber(category) does not work.')
	assert(sum(cellfun(@(category) m.getPropNumber(category), categories)) == Distance.getPropNumber(), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.getPropNumber(category) does not work.')
	assert(sum(cellfun(@(category) Element.getPropNumber(m, category), categories)) == Distance.getPropNumber(), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getPropNumber(m, category) does not work.')
	assert(sum(cellfun(@(category) Element.getPropNumber('Distance', category), categories)) == Distance.getPropNumber(), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.getPropNumber(''Distance'', category) does not work.')
	 
	% existsProp(prop)
	assert(~Distance.existsProp(NaN), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.existsProp(prop) does not work.')
	assert(~m.existsProp(NaN), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.existsProp(prop) does not work.')
	assert(~Element.existsProp(m, NaN), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.existsProp(m, prop) does not work.')
	assert(~Element.existsProp('Distance', NaN), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.existsProp(''Distance'', prop) does not work.')
	 
	assert_with_error('Distance.existsProp(NaN)', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT])
	assert_with_error('varargin{1}.existsProp(NaN)', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], m)
	assert_with_error('Element.existsProp(varargin{1}, NaN)', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], m)
	assert_with_error('Element.existsProp(''Distance'', NaN)', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT])
	 
	for prop = 1:1:Distance.getPropNumber()
		assert(Distance.existsProp(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.existsProp(prop) does not work.')
		assert(m.existsProp(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.existsProp(prop) does not work.')
		assert(Element.existsProp(m, prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.existsProp(m, prop) does not work.')
		assert(Element.existsProp('Distance', prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.existsProp(''Distance'', prop) does not work.')
	end
	 
	% existsTag(tag)
	assert(~Distance.existsTag(''), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.existsTag(tag) does not work.')
	assert(~m.existsTag(''), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'm.existsTag(tag) does not work.')
	assert(~Element.existsTag(m, ''), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.existsTag(m, tag) does not work.')
	assert(~Element.existsTag('Distance', ''), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Element.existsTag(''Distance'', tag) does not work.')
	 
	assert_with_error('Distance.existsTag('''')', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT])
	assert_with_error('varargin{1}.existsTag('''')', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], m)
	assert_with_error('Element.existsTag(varargin{1}, '''')', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], m)
	assert_with_error('Element.existsTag(''Distance'', '''')', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT])
	 
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
		assert(Distance.existsTag(tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.existsTag(tag) does not work.')
		assert(m.existsTag(tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.existsTag(tag) does not work.')
		assert(Element.existsTag(m, tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.existsTag(m, tga) does not work.')
		assert(Element.existsTag('Distance', tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.existsTag(''Distance'', tag) does not work.')
	end
	 
	% getPropProp(pointer)
	for prop = 1:1:Distance.getPropNumber()
		assert(Distance.getPropProp(prop) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropProp(prop) does not work.')
		assert(m.getPropProp(prop) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropProp(prop) does not work.')
		assert(Element.getPropProp(m, prop) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropProp(m, prop) does not work.')
		assert(Element.getPropProp('Distance', prop) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropProp(''Distance'', prop) does not work.')
	 
		tag = m.getPropTag(prop);
		assert(Distance.getPropProp(tag) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropProp(tag) does not work.')
		assert(m.getPropProp(tag) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropProp(tag) does not work.')
		assert(Element.getPropProp(m, tag) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropProp(m, tag) does not work.')
		assert(Element.getPropProp('Distance', prop) == prop, ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropProp(''Distance'', tag) does not work.')
	end
	 
	% getPropTag(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		assert(strcmp(Distance.getPropTag(prop), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropTag(prop) does not work.')
		assert(strcmp(m.getPropTag(prop), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropTag(prop) does not work.')
		assert(strcmp(Element.getPropTag(m, prop), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropTag(m, prop) does not work.')
		assert(strcmp(Element.getPropTag('Distance', prop), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropTag(''Distance'', prop) does not work.')
	 
		assert(strcmp(Distance.getPropTag(tag), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropTag(tag) does not work.')
		assert(strcmp(m.getPropTag(tag), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropTag(tag) does not work.')
		assert(strcmp(Element.getPropTag(m, tag), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropTag(m, tag) does not work.')
		assert(strcmp(Element.getPropTag('Distance', prop), tag), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropTag(''Distance'', tag) does not work.')
	end
	 
	% getPropCategory(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		assert(Category.existsCategory(Distance.getPropCategory(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropCategory(prop) does not work.')
		assert(Category.existsCategory(m.getPropCategory(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropCategory(prop) does not work.')
		assert(Category.existsCategory(Element.getPropCategory(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropCategory(m, prop) does not work.')
		assert(Category.existsCategory(Element.getPropCategory(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropCategory(''Distance'', prop) does not work.')
	 
		assert(Category.existsCategory(Distance.getPropCategory(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropCategory(tag) does not work.')
		assert(Category.existsCategory(m.getPropCategory(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropCategory(tag) does not work.')
		assert(Category.existsCategory(Element.getPropCategory(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropCategory(m, tag) does not work.')
		assert(Category.existsCategory(Element.getPropCategory(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropCategory(''Distance'', tag) does not work.')
	end
	 
	% getPropFormat(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		assert(Format.existsFormat(Distance.getPropFormat(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropFormat(prop) does not work.')
		assert(Format.existsFormat(m.getPropFormat(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropFormat(prop) does not work.')
		assert(Format.existsFormat(Element.getPropFormat(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropFormat(m, prop) does not work.')
		assert(Format.existsFormat(Element.getPropFormat(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropFormat(''Distance'', prop) does not work.')
	 
		assert(Format.existsFormat(Distance.getPropFormat(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropFormat(tag) does not work.')
		assert(Format.existsFormat(m.getPropFormat(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropFormat(tag) does not work.')
		assert(Format.existsFormat(Element.getPropFormat(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropFormat(m, tag) does not work.')
		assert(Format.existsFormat(Element.getPropFormat(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropFormat(''Distance'', tag) does not work.')
	end
	 
	% getPropDescription(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		assert(ischar(Distance.getPropDescription(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropDescription(prop) does not work.')
		assert(ischar(m.getPropDescription(prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropDescription(prop) does not work.')
		assert(ischar(Element.getPropDescription(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropDescription(m, prop) does not work.')
		assert(ischar(Element.getPropDescription(m, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropDescription(''Distance'', prop) does not work.')
	 
		assert(ischar(Distance.getPropDescription(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.getPropDescription(tag) does not work.')
		assert(ischar(m.getPropDescription(tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.getPropDescription(tag) does not work.')
		assert(ischar(Element.getPropDescription(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropDescription(m, tag) does not work.')
		assert(ischar(Element.getPropDescription(m, tag)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.getPropDescription(''Distance'', tag) does not work.')
	end
	 
	% getPropSettings(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		settings = Distance.getPropSettings(prop);
		settings = m.getPropSettings(prop);
		settings = Element.getPropSettings(m, prop);
		settings = Element.getPropSettings('Distance', prop);
	 
		settings = Distance.getPropSettings(tag);
		settings = m.getPropSettings(tag);
		settings = Element.getPropSettings(m, tag);
		settings = Element.getPropSettings('Distance', tag);
	end
	 
	% getPropDefault(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		default = Distance.getPropDefault(prop);
		default = m.getPropDefault(prop);
		default = Element.getPropDefault(m, prop);
		default = Element.getPropDefault('Distance', prop);
	 
		default = Distance.getPropDefault(tag);
		default = m.getPropDefault(tag);
		default = Element.getPropDefault(m, tag);
		default = Element.getPropDefault('Distance', tag);
	end
	 
	% getPropDefaultConditioned(pointer)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		conditioned_default = Distance.getPropDefaultConditioned(prop);
		conditioned_default = m.getPropDefaultConditioned(prop);
		conditioned_default = Element.getPropDefaultConditioned(m, prop);
		conditioned_default = Element.getPropDefaultConditioned('Distance', prop);
	 
		conditioned_default = Distance.getPropDefaultConditioned(tag);
		conditioned_default = m.getPropDefaultConditioned(tag);
		conditioned_default = Element.getPropDefaultConditioned(m, tag);
		conditioned_default = Element.getPropDefaultConditioned('Distance', tag);
	end
	 
	% checkProp(pointer, value)
	for prop = 1:1:Distance.getPropNumber()
		tag = m.getPropTag(prop);
	 
		assert(~Distance.checkProp(prop, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.checkProp(prop, value) does not work.')
		assert(~m.checkProp(prop, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.checkProp(prop, value) does not work.')
		assert(~Element.checkProp(m, prop, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(m, prop, value) does not work.')
		assert(~Element.checkProp('Distance', prop, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(''Distance'', prop, value) does not work.')
	 
		assert_with_error('Distance.checkProp(varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], prop)
		assert_with_error('varargin{2}.checkProp(varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], prop, m)
		assert_with_error('Element.checkProp(varargin{2}, varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], prop, m)
		assert_with_error('Element.checkProp(''Distance'', varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], prop)
	 
		assert(~Distance.checkProp(tag, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.checkProp(tag, value) does not work.')
		assert(~m.checkProp(tag, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.checkProp(tag, value) does not work.')
		assert(~Element.checkProp(m, tag, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(m, tag, value) does not work.')
		assert(~Element.checkProp('Distance', tag, {'probably wrong value', 1}), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(''Distance'', tag, value) does not work.')
	 
		assert_with_error('Distance.checkProp(varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], tag)
		assert_with_error('varargin{2}.checkProp(varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], tag, m)
		assert_with_error('Element.checkProp(varargin{2}, varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], tag, m)
		assert_with_error('Element.checkProp(''Distance'', varargin{1}, {''probably wrong value'', 1})', [BRAPH2.STR ':Distance:' BRAPH2.WRONG_INPUT], tag)
	 
		assert(Distance.checkProp(prop, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.checkProp(prop, <conditioned default value>) does not work.')
		assert(m.checkProp(prop, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.checkProp(prop, <conditioned default value>) does not work.')
		assert(Element.checkProp(m, prop, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(m, prop, <conditioned default value>) does not work.')
		assert(Element.checkProp('Distance', prop, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(''Distance'', prop, <conditioned default value>) does not work.')
	 
		assert(Distance.checkProp(tag, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.checkProp(tag, <conditioned default value>) does not work.')
		assert(m.checkProp(tag, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'm.checkProp(tag, <conditioned default value>) does not work.')
		assert(Element.checkProp(m, tag, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(m, tag, <conditioned default value>) does not work.')
		assert(Element.checkProp('Distance', tag, Element.getPropDefaultConditioned(Distance, prop)), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Element.checkProp(''Distance'', tag, <conditioned default value>) does not work.')
	 
	end
	 
end

%% Test 2: Instantiation - defaults
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	for prop = 1:1:Distance.getPropNumber()
	 
		% excluded props
		if any(prop == [Distance.PFM])
			continue
		end
	 
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case {Category.CONSTANT, Category.RESULT, Category.QUERY}
				% getr
				assert( ...
					m.getr(prop) == Distance.getNoValue(), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Being a ' Distance.getCategoryName(Distance.getPropCategory(prop)) ', Distance.getr(' int2str(prop) ') must be inizialized to NoValue(). ' ...
					'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
					)
				assert( ...
					m.getr(TAG) == Distance.getNoValue(), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Being a ' Distance.getCategoryName(Distance.getPropCategory(prop)) ', Distance.getr(' TAG ') must be inizialized to NoValue(). ' ...
					'Or there could be an error in Distance.getr(' TAG ').'] ...
					)
				% get
				assert( ...
					~isa(m.get(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				if isempty(m.getPropSettings(prop))
					assert( ...
						m.checkFormat(m.getPropFormat(prop), m.get(prop)), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
						)
				else
					assert( ...
						m.checkFormat(m.getPropFormat(prop), m.get(prop), m.getPropSettings(prop)), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
						)
				end
			case Category.EVANESCENT
				% getr
				assert( ...
					m.getr(prop) == Distance.getNoValue(), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Being a ' Distance.getCategoryName(Distance.getPropCategory(prop)) ', Distance.getr(' int2str(prop) ') must be inizialized to NoValue(). ' ...
					'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
					)
				assert( ...
					m.getr(TAG) == Distance.getNoValue(), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Being a ' Distance.getCategoryName(Distance.getPropCategory(prop)) ', Distance.getr(' TAG ') must be inizialized to NoValue(). ' ...
					'Or there could be an error in Distance.getr(' TAG ').'] ...
					)
				% get
				warning_backup = warning('off', [BRAPH2.STR ':Distance']);
				assert( ...
					~isa(m.get(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				if isempty(m.getPropSettings(prop))
					assert( ...
						m.checkFormat(m.getPropFormat(prop), m.get(prop)), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
						)
				else
					assert( ...
						m.checkFormat(m.getPropFormat(prop), m.get(prop), m.getPropSettings(prop)), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
						)
				end
				warning(warning_backup)
			otherwise % case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
				assert( ...
					isequal(m.getr(prop), Distance.getPropDefaultConditioned(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be inizialized to its default value ' ...
					'given by Distance.getPropDefaultConditioned(' int2str(prop) '). ' ...
					'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
					)
				assert( ...
					isequal(m.getr(TAG), Distance.getPropDefaultConditioned(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' TAG ') must be inizialized to its default value ' ...
					'given by Distance.getPropDefaultConditioned(' int2str(prop) '). ' ...
					'Or there could be an error in Distance.getr(' TAG ').'] ...
					)
		end
	end
end

%% Test 3: Memorize
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	for prop = 1:1:Distance.getPropNumber()
	 
		% excluded props
		if any(prop == [Distance.PFM])
			continue
		end
	 
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case Category.RESULT
				assert( ...
					~isa(m.get(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				assert( ...
					isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a NoValue, because it should NOT have been memorized.'] ...
					)
				assert( ...
					~isa(m.memorize(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.memorize(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				assert( ...
					~isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must NOT be a NoValue, because it should have been memorized.'] ...
					)
				assert( ...
					m.checkFormat(m.getPropFormat(prop), m.getr(prop),m.getPropSettings(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') returns a value with the wrong format.'] ...
					)
			case Category.QUERY
	% 			warning_backup = warning('off', [BRAPH2.STR ':Distance']);
				assert( ...
					~isa(m.get(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				assert( ...
					isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a NoValue, because it should NOT have been memorized.'] ...
					)
	% following tests excluded because properties QUERY should not be memorized
	% 			warning_backup = warning('off', [BRAPH2.STR ':Distance']);
	% 			assert( ...
	% 				~isa(m.memorize(prop), 'NoValue'), ...
	% 				[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	% 				['Distance.memorize(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
	% 				)
	% 			warning(warning_backup)
	% 			assert( ...
	% 				~isa(m.getr(prop), 'NoValue'), ...
	% 				[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	% 				['Distance.getr(' int2str(prop) ') must NOT be a NoValue, because it should have been memorized.'] ...
	% 				)
	% 			assert( ...
	% 				m.checkFormat(m.getPropFormat(prop), m.getr(prop),m.getPropSettings(prop)), ...
	% 				[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	% 				['Distance.getr(' int2str(prop) ') returns a value with the wrong format.'] ...
	% 				)
	% 			warning(warning_backup)
			case Category.EVANESCENT
				warning_backup = warning('off', [BRAPH2.STR ':Distance']);
				assert( ...
					~isa(m.get(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				warning(warning_backup)
				assert( ...
					isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a NoValue, because it should NOT have been memorized.'] ...
					)
				assert( ...
					~isa(m.memorize(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.memorize(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
					)
				assert( ...
					~isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must NOT be a NoValue, because it should have been memorized.'] ...
					)
				assert( ...
					m.checkFormat(m.getPropFormat(prop), m.getr(prop),m.getPropSettings(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') returns a value with the wrong format.'] ...
					)
				if m.getPropFormat(prop) == Format.HANDLE
					warning_backup = warning('off', 'BRAPH2:Distance');
					delete(ancestor(m.get(prop), 'figure'))
					warning(warning_backup)
				end
		end
	end
	 
	if ~isempty(Distance.getProps(Category.RESULT))
		for prop = 1:1:Distance.getPropNumber()
	 
			% excluded props
			if any(prop == [Distance.PFM])
				continue
			end
	 
			switch Distance.getPropCategory(prop)
				case {Category.PARAMETER, Category.DATA}
					assert( ...
						m.isLocked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.isLocked(' int2str(prop) ') must be locked because a result has been calculated.'] ...
						)
				otherwise
					assert( ...
						~m.isLocked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance.isLocked(' int2str(prop) ') must NOT be locked even though a result has been calculated.'] ...
						)
			end
		end
	end
end

%% Test 4: Lock 1
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance();
	 
	for prop = 1:1:Distance.getPropNumber()
		TAG = upper(Distance.getPropTag(prop));
		assert( ...
			~m.isLocked(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isLocked(' int2str(prop) ') must NOT be locked when it is instantiated.'] ...
			)
		assert( ...
			~m.isLocked(TAG), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isLocked(' TAG ') must NOT be locked when it is instantiated.'] ...
			)
	end
	 
	m.lock()
	 
	for prop = 1:1:Distance.getPropNumber()
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER, Category.DATA}
				assert( ...
					m.isLocked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.isLocked(' int2str(prop) ') must be locked because the element is now locked.'] ...
					)
			case {Category.CONSTANT, Category.METADATA, Category.RESULT, Category.QUERY, Category.EVANESCENT, Category.FIGURE, Category.GUI}
				assert( ...
					~m.isLocked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.isLocked(' int2str(prop) ') must NOT be locked even though the element is now locked.'] ...
					)
		end
	end
end

%% Test 5: Lock 2
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance();
	 
	warning_backup = warning('off', 'BRAPH2:Distance');
	for prop = 1:1:Distance.getPropNumber()
		m.lock(prop)
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
				assert( ...
					m.isLocked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.isLocked(' int2str(prop) ') must be locked.'] ...
					)
			case {Category.CONSTANT, Category.METADATA, Category.RESULT, Category.QUERY, Category.EVANESCENT}
				assert( ...
					~m.isLocked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.isLocked(' int2str(prop) ') must NOT be locked even though locking has been attempted.'] ...
					)
		end
	end
	warning(warning_backup)
end

%% Test 6: Check
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance();
	 
	for prop = 1:1:Distance.getPropNumber()
		TAG = upper(Distance.getPropTag(prop));
		assert( ...
			m.isChecked(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isChecked(' int2str(prop) ') must be checked when it is instantiated.'] ...
			)
		assert( ...
			m.isChecked(TAG), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isChecked(' TAG ') must be checked when it is instantiated.'] ...
			)
	end
	 
	m.unchecked()
	 
	for prop = 1:1:Distance.getPropNumber()
		assert( ...
			~m.isChecked(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isChecked(' int2str(prop) ') must NOT be checked because it has been set to unchecked.'] ...
			)
	end
	 
	m.checked()
	 
	for prop = 1:1:Distance.getPropNumber()
		assert( ...
			m.isChecked(prop), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			['Distance.isChecked(' int2str(prop) ') must be checked because it has been set to checked.'] ...
			)
	end
end

%% Test 7: Callbacks
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	% basic Distance
	m_0 = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	% Distance with 1st callbacks
	m_1 = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, m_0.getCallback(4), ..., ...
		Distance.ID, m_0.getCallback(5), ..., ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, m_0.getCallback(13), ..., ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, m_0.getCallback(15) ... ...
		);
	 
	prop_number = Distance.getPropNumber();
	for prop = 1:1:prop_number
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
				assert( ...
					isa(m_1.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a callback.'] ...
					)
				assert( ...
					isequal(m_1.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
					)
			otherwise
				assert( ...
					~isa(m_1.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
					)
		end
	end
	 
	% Distance with 2nd callbacks
	m_2 = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, m_1.getCallback(4), ..., ...
		Distance.ID, m_1.getCallback(5), ..., ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, m_1.getCallback(13), ..., ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, m_1.getCallback(15) ... ...
		);
	 
	prop_number = Distance.getPropNumber();
	for prop = 1:1:prop_number
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
				assert( ...
					isa(m_2.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a callback.'] ...
					)
				assert( ...
					isequal(m_2.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
					)
			otherwise
				assert( ...
					~isa(m_2.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
					)
		end
	end
	 
	% Distance with 3rd callbacks
	m_3 = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, m_2.getCallback(4), ..., ...
		Distance.ID, m_2.getCallback(5), ..., ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, m_2.getCallback(13), ..., ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, m_2.getCallback(15) ... ...
		);
	 
	prop_number = Distance.getPropNumber();
	for prop = 1:1:prop_number
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
				assert( ...
					isa(m_3.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must be a callback.'] ...
					)
				assert( ...
					isequal(m_3.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
					)
			otherwise
				assert( ...
					~isa(m_3.getr(prop), 'Callback'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
					)
		end
	end
	 
end

%% Test 8: Copy
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	% copy empty element
	m = Distance();
	 
	m_copy = m.copy();
	 
	assert(m_copy ~= m, ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.copy() does not work. A copied element must point to a copied element.')
	assert(isequal(m_copy, m), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.copy() does not work. A copied element must have the same property values of the original element.')
	 
	for prop = 1:1:Distance.getPropNumber()
		value = m.getr(prop);
		value_copy = m_copy.getr(prop);
		switch Distance.getPropCategory(prop)
			case {Category.EVANESCENT}
				assert( ...
					isa(value_copy, 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The copied value of an EVANESCENT property must be NoValue.' ...
					)
			otherwise
				if isa(value, 'NoValue')
					assert( ...
						value_copy == value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. There should be a unique instance of NoValue.' ...
						)
				elseif isa(value, 'Element')
					assert( ...
						value_copy ~= value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
						)
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
						)
				elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
					for j = 1:1:length(value)
						assert( ...
							value_copy ~= value, ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
							)
						assert( ...
							isequal(value_copy, value), ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
							)
					end
				else
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The value copy should be equal to the original.' ...
						)
				end
				assert( ...
					m_copy.isLocked(prop) == m.isLocked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The locked status of the copied and original elements must be the same.' ...
					)
				assert( ...
					m_copy.isChecked(prop) == m.isChecked(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The checked status of the copied and original elements must be the same.' ...
					)
				assert( ...
					m_copy.getPropSeed(prop) == m.getPropSeed(prop), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The randomization seeds of the copied and original elements must be the same.' ...
					)
		end
	end
	 
	% copy element with default initialization and memorization
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	for prop = 1:1:Distance.getPropNumber()
		if Distance.getPropCategory(prop) == Category.QUERY
			% properties QUERY should not be memorized
			% warning_backup = warning('off', [BRAPH2.STR ':Distance']);
			% m.memorize(prop);
			% warning(warning_backup)
		elseif Distance.getPropCategory(prop) == Category.EVANESCENT && m.getPropFormat(prop) == Format.HANDLE
			m.memorize(prop);
			warning_backup = warning('off', 'BRAPH2:Distance');
			delete(ancestor(m.get(prop), 'figure'))
			warning(warning_backup)
		else
			m.memorize(prop);
		end
	end
	 
	% copy element with default initialization
	m_copy = m.copy();
	 
	for prop = 1:1:Distance.getPropNumber()
		value = m.getr(prop);
		value_copy = m_copy.getr(prop);
		switch Distance.getPropCategory(prop)
			case {Category.EVANESCENT Category.QUERY}
				assert( ...
					isa(value_copy, 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The copied value of an EVANESCENT property must be NoValue.' ...
					)
			otherwise
				if isa(value, 'NoValue')
					assert( ...
						value_copy == value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. There should be a unique instance of NoValue.' ...
						)
				elseif isa(value, 'Element')
					assert( ...
						value_copy ~= value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
						)
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
						)
				elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
					for j = 1:1:length(value)
						assert( ...
							value_copy ~= value, ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
							)
						assert( ...
							isequal(value_copy, value), ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
							)
					end
				else
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The value copy should be equal to the original.' ...
						)
				end
	 
					assert( ...
						m_copy.isLocked(prop) == m.isLocked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The locked status of the copied and original elements must be the same.' ...
						)
	 
					assert( ...
						m_copy.isChecked(prop) == m.isChecked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The checked status of the copied and original elements must be the same.' ...
						)
	 
					assert( ...
						m_copy.getPropSeed(prop) == m.getPropSeed(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The randomization seeds of the copied and original elements must be the same.' ...
						)
		end
	end
	 
	% copy element with callbacks
	m_0 = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, m_0.getCallback(4), ..., ...
		Distance.ID, m_0.getCallback(5), ..., ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, m_0.getCallback(13), ..., ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, m_0.getCallback(15) ... ...
		);
	 
	m_copy = m.copy();
	m_0_copy = m_copy.getr('ID').get('EL');
	 
	for prop = 1:1:Distance.getPropNumber()
		value = m.getr(prop);
		value_copy = m_copy.getr(prop);
		switch Distance.getPropCategory(prop)
			case {Category.EVANESCENT}
				assert( ...
					isa(value_copy, 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					'Distance.copy() does not work. The copied value of an EVANESCENT property must be NoValue.' ...
					)
			otherwise
				if isa(value, 'NoValue')
					assert( ...
						value_copy == value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. There should be a unique instance of NoValue.' ...
						)
				elseif isa(value, 'Element')
					assert( ...
						value_copy ~= value, ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
						)
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
						)
				elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
					for j = 1:1:length(value)
						assert( ...
							value_copy ~= value, ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. The handle of a copied element should point to a copied element.' ...
							)
						assert( ...
							isequal(value_copy, value), ...
							[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
							'Distance.copy() does not work. When empty, a copied element should be equal to the element.' ...
							)
					end
				else
					assert( ...
						isequal(value_copy, value), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The value copy should be equal to the original.' ...
						)
				end
				if isa(value, 'Callback')
					assert( ...
						value == m_0.getCallback(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The callback should be obtained from Distance.getCallback().' ...
						)
					assert( ...
						value_copy == m_0_copy.getCallback(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The callback should be obtained from Distance.getCallback().' ...
						)
				end
	 
					assert( ...
						m_copy.isLocked(prop) == m.isLocked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The locked status of the copied and original elements must be the same.' ...
						)
	 
					assert( ...
						m_copy.isChecked(prop) == m.isChecked(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The checked status of the copied and original elements must be the same.' ...
						)
	 
					assert( ...
						m_copy.getPropSeed(prop) == m.getPropSeed(prop), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance.copy() does not work. The randomization seeds of the copied and original elements must be the same.' ...
						)
		end
	end
	 
end

%% Test 9: Template
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m_template = Distance();
	m = Distance('TEMPLATE', m_template);
	 
	for prop = 1:1:Distance.getPropNumber()
	 
		% excluded props
		if any(prop == [Distance.PFM])
			continue
		end
	 
		TAG = upper(Distance.getPropTag(prop));
		switch Distance.getPropCategory(prop)
			case {Category.PARAMETER}
				if prop == Distance.TEMPLATE
					assert( ...
						isa(m.getr(prop), 'Distance'), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance TEMPLATE does not work. Distance.getr(''TEMPLATE'') should be a Distance element.' ...
						)
					assert( ...
						isa(m_template.getr(prop), 'NoValue'), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						'Distance TEMPLATE does not work. Distance_template.getr(''TEMPLATE'') should be a NoValue.' ...
						)
				else
					assert( ...
						isa(m.getr(prop), 'Callback'), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance TEMPLATE does not work. Distance.getr(' TAG ') should be a Callback.'] ...
						)
					assert( ...
						m.getr(prop).get('EL') == m_template && m.getr(prop).get('PROP') == prop && strcmp(m.getr(prop).get('TAG'), TAG), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance TEMPLATE does not work. Distance.getr(' TAG ') should be a Callback to m_template.' TAG '.'] ...
						)
					assert( ...
						isa(m_template.getr(prop), 'NoValue'), ...
						[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
						['Distance TEMPLATE does not work. Distance_template.getr(' TAG ') should be a NoValue.'] ...
						)
				end
			otherwise
				assert( ...
					isa(m.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance TEMPLATE does not work. Distance.getr(' TAG ') should be a NoValue.'] ...
					)
				assert( ...
					isa(m_template.getr(prop), 'NoValue'), ...
					[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
					['Distance TEMPLATE does not work. Distance_template.getr(' TAG ') should be a NoValue.'] ...
					)
		end
	end
end

%% Test 10: Save Load
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	filename = [fileparts(which('test_braph2')) filesep 'distance_to_be_erased.b2'];
	 
	Element.save(m, filename)
	 
	m_loaded = Element.load(filename);
	 
	assert( ...
		isequal(m.copy(), m_loaded), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.save(m) and/or Distance.load() do not work.' ...
		)
	 
	delete(filename)
end

%% Test 11: JSON
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	m = Distance( ...
		Distance.ELCLASS, Distance.getNoValue(), ...
		Distance.NAME, Distance.getNoValue(), ...
		Distance.DESCRIPTION, Distance.getNoValue(), ...
		Distance.TEMPLATE, Distance.getPropDefault(Distance.TEMPLATE), ...
		Distance.ID, Distance.getPropDefault(Distance.ID), ...
		Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
		Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
		Distance.TOSTRING, Distance.getNoValue(), ...
		Distance.SHAPE, Distance.getNoValue(), ...
		Distance.SCOPE, Distance.getNoValue(), ...
		Distance.PARAMETRICITY, Distance.getNoValue(), ...
		Distance.COMPATIBLE_GRAPHS, Distance.getNoValue(), ...
		Distance.G, Distance.getPropDefault(Distance.G), ...
		Distance.M, Distance.getNoValue(), ...
		Distance.PFM, Distance.getPropDefault(Distance.PFM) ...
		);
	 
	[json, struct, el_list] = encodeJSON(m);
	[m_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);
	 
	assert(m_dec ~= m, ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		'Distance.encodeJSON() or Distance.decodeJSON() does not work. A JSON encoded/decoded element must point to an element other than the original one.' ...
		)
	if all(cellfun(@(prop) Distance.getPropFormat(prop), num2cell(Distance.getProps())) == Format.HANDLE) && all(cellfun(@(prop) Distance.getPropFormat(prop), num2cell(Distance.getProps())) == Format.NET)
		assert(isequal(m_dec, m), ...
			[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
			'Distance.encodeJSON() or Distance.decodeJSON() does not work. A JSON encoded/decoded element must have the same property values of the original element.' ...
			)
	end
end

%% Test 12: GraphBD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   1	1   1   0
	    1	0   0   0   0
	    1   1   0   1   0
	    1   1   0   0   0
	    0	0   0   0   0
	    ];
	
	known_distance = {[
	    0   1   1   1   Inf
	    1   0   2   2   Inf
	    1   1   0   1   Inf
	    1   1   2   0   Inf
	    Inf Inf Inf Inf 0
	    ]};
	
	g = GraphBD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 13: GraphBU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0	1   1	1   0
	    1   0   0   1   0
	    1   0   0   1   0
	    1   1   1   0   0
	    0	0	0   0   0
	    ];
	
	known_distance = {[
	    0   1   1   1   Inf
	    1   0   2   1   Inf
	    1   2   0   1   Inf
	    1   1   1   0   Inf
	    Inf Inf Inf Inf 0
	    ]};
	
	g = GraphBU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 14: GraphWD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0     .1  .2  .25  0
	    .125  0   0   0    0
	    .2    .5  0   .25  0
	    .125  10   0   0   0
	    0     0   0   0    0
	    ];
	
	known_distance = {[
	    0   5   5   4   Inf
	    8   0   13  12  Inf
	    5   2   0   4   Inf
	    8   1   13  0   Inf
	    Inf Inf Inf Inf 0
	    ]};
	
	g = GraphWD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 15: GraphWU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [0 0.1 0;
	     0.1 0 0.2;
	     0 0.2 0];
	
	known_distance = {[0	10	15
	                  10     0 	5
	                  15	 5	0]};
	
	g = GraphWU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 16: MultigraphBUD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	densities = [0 33 67 100];
	
	known_distance = {
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    };
	
	g = MultigraphBUD('B', B, 'DENSITIES', densities);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 17: MultigraphBUT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   0
	    .7   0   0
	    ];
	
	thresholds = [0 .5 1];
	
	known_distance = {
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    };
	
	g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 18: MultiplexBD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B22 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B = {B11 B22};
	known_distance = {
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = MultiplexBD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 19: MultiplexBU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1  0    0;
	    1   0   0  0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B22 = [
	    0   1   1   1   0; 
	    1   0   0   0   0;
	    1   1   0   1   0;
	    1   1   0   0   0;
	    0   0   0   0   0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = MultiplexBU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 20: MultiplexWD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = MultiplexWD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 21: MultiplexWU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    };
	
	g = MultiplexWU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 22: MultiplexBUD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	densities = [0 33 67 100];
	
	known_distance = {
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    };
	
	g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 23: MultiplexBUT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   0
	    .7   0   0
	    ];
	
	thresholds = [0 .5 1];
	
	known_distance = {
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    };
	
	g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 24: OrdMxWU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    };
	
	g = OrdMxWU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 25: OrdMxWD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMxWD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 26: OrdMxBD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B22 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B = {B11 B22};
	known_distance = {
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMxBD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 27: OrdMxBU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1  0    0;
	    1   0   0  0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B22 = [
	    0   1   1   1   0; 
	    1   0   0   0   0;
	    1   1   0   1   0;
	    1   1   0   0   0;
	    0   0   0   0   0;
	    ];
	B = {B11 B22};
	
	known_distance = {
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMxBU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 28: OrdMxBUT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   0
	    .7   0   0
	    ];
	
	thresholds = [0 .5 1];
	
	known_distance = {
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    };
	
	g = OrdMxBUT('B', {B B B}, 'THRESHOLDS', thresholds);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 29: OrdMxBUD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	densities = [0 33 67 100];
	
	known_distance = {
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1   Inf 0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    };
	
	g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 30: MultilayerWU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0  0;
	    .125    0   0   0    0  0;
	    .2      .5  0   .25  0  0;
	    .125    10  0   0    0  0;
	    0       0   0   0    0  0;
	    0       0   0   0    0  0 
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf Inf;
	    5   0   2   1   Inf Inf;
	    5   2   0   3   Inf Inf;
	    4   1   3   0   Inf Inf;
	    Inf Inf Inf Inf 0   Inf;
	    Inf Inf Inf Inf Inf   0;
		]
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    };
	
	g = MultilayerWU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 31: OrdMlWU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0  0;
	    .125    0   0   0    0  0;
	    .2      .5  0   .25  0  0;
	    .125    10  0   0    0  0;
	    0       0   0   0    0  0;
	    0       0   0   0    0  0 
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B12 = rand(size(B11, 1),size(B22, 2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf Inf;
	    5   0   2   1   Inf Inf;
	    5   2   0   3   Inf Inf;
	    4   1   3   0   Inf Inf;
	    Inf Inf Inf Inf 0   Inf;
	    Inf Inf Inf Inf Inf   0;
		]
	    [
	    0   5   5   4   Inf;
	    5   0   2   1   Inf;
	    5   2   0   3   Inf;
	    4   1   3   0   Inf;
	    Inf Inf Inf Inf 0;
		]
	    };
	
	g = OrdMlWU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 32: OrdMlWD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	B22 = [
	    0       .1  .2  .25  0;
	    .125    0   0   0    0;
	    .2      .5  0   .25  0;
	    .125    10  0   0    0;
	    0       0   0   0    0;
	    ];
	
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	
	known_distance = {
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   5   5   4   Inf;
	    8   0   13  12  Inf;
	    5   2   0   4   Inf;
	    8   1   13  0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMlWD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 33: MultilayerBUT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0    0.6
	    0.6  0
	    ];
	B22 = [
	    0   .2   .7
	    .2   0   0
	    .7   0   0
	    ];
	B33 = [
	    0   1   0  .2
	    1   0   .3  .1
	    0  .3   0   0
	   .2  .1   0   0
	    ];
	
	thresholds = [0 .5 1];
	
	known_distance = {
	    [
	    0   1
	    1   0
	    ]
	    [
	    0   1   1
	    1   0   2
	    1   2   0
	    ]
	    [
	    0   1   2  1
	    1   0   1  1
	    2   1   0  2
	    1   1   2  0
	    ]
	    [
	    0   1
	    1   0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0   1   Inf  Inf
	    1   0   Inf  Inf
	    Inf Inf 0    Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0   Inf
	    Inf 0
	    ]
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0
	    ]
	    [
	    0   Inf Inf Inf
	    Inf 0   Inf Inf
	    Inf Inf 0   Inf
	    Inf Inf Inf 0
	    ]
	    };
	
	B12 = rand(size(B11,1),size(B22,2));
	B13 = rand(size(B11,1),size(B33,2));
	B23 = rand(size(B22,1),size(B33,2));
	B21 = B12';
	B32 = B23';
	B31 = B13';
	
	B= {B11 B12 B13;
	    B21 B22 B23;
	    B31 B32 B33};
	
	g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 34: OrdMlBD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B22 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	known_distance = {
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   2   2   Inf;
	    1   1   0   1   Inf;
	    1   1   2   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMlBD('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 35: MultilayerBU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1	1	0	0	0;
	    1	0	0	0	0	0; 
	    1	1	0	1	0	0;
	    1	1	0	0   0	0;
	    0	0	0	0   0	0;
	    0	0	0	0   0	0;
	    ];
	B22 = [
	    0	1 	1	1	0;
	    1	0	0	0	0; 
	    1	1	0	1	0;
	    1	1	0	0	0;
	    0	0	0	0	0;
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	known_distance = {
	    [
	    0   1   1   1   Inf   Inf;
	    1   0   1   1   Inf   Inf;
	    1   1   0   1   Inf   Inf;
	    1   1   1   0   Inf   Inf;
	    Inf Inf Inf Inf 0   Inf;
	    Inf Inf Inf Inf Inf  0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = MultilayerBU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 36: MultilayerBUD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	B22 = [    
	    0   .2   .7 .5
	    .2   0   .1 .5
	    .7  .1   0  .5
	    .5  .5  .5  0
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	densities = [0 33 67 100];
	
	known_distance = {
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf Inf
	    Inf 0   Inf Inf
	    Inf Inf 0   Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0    
	    ]
	    [
	    0 Inf 1 Inf
	    Inf 0 Inf Inf
	    1 Inf 0 Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0	1	1
	    1	0	2
	    1   2	0
	    ]
	    [
	    0 2 1 1
	    2 0 2 1
	    1 2 0 1
	    1 1 1 0
	    ]
	    [
	    0 1 1
	    1 0 1
	    1 1 0
	    ]
	    [
	    0 1 1 1
	    1 0 1 1
	    1 1 0 1
	    1 1 1 0
	    ]
	    };
	
	g = MultilayerBUD('B', B, 'DENSITIES', densities);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 37: OrdMlBU
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0	1   1   0   0   0;
	    1   0   0   0	0   0; 
	    1   1   0   1   0   0;
	    1	1   0   0   0   0;
	    0   0   0   0   0   0;
	    0   0   0   0   0   0;
	    ];
	B22 = [
	    0	1   1   1   0;
	    1   0   0   0	0; 
	    1   1   0   1   0;
	    1	1   0   0   0;
	    0   0   0   0   0;
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	known_distance = {
	    [
	    0   1   1   1   Inf   Inf;
	    1   0   1   1   Inf   Inf;
	    1   1   0   1   Inf   Inf;
	    1   1   1   0   Inf   Inf;
	    Inf Inf Inf Inf 0   Inf;
	    Inf Inf Inf Inf Inf  0;
	    ]
	    [
	    0   1   1   1   Inf;
	    1   0   1   1   Inf;
	    1   1   0   1   Inf;
	    1   1   1   0   Inf;
	    Inf Inf Inf Inf 0;
	    ]
	    };
	
	g = OrdMlBU('B', B);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 38: OrdMlBUD
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	B22 = [    
	    0   .2   .7 .5
	    .2   0   .1 .5
	    .7  .1   0  .5
	    .5  .5  .5  0
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	densities = [0 33 67 100];
	
	known_distance = {
	    [
	    0   Inf Inf
	    Inf 0   Inf
	    Inf Inf 0    
	    ]
	    [
	    0   Inf Inf Inf
	    Inf 0   Inf Inf
	    Inf Inf 0   Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0    
	    ]
	    [
	    0 Inf 1 Inf
	    Inf 0 Inf Inf
	    1 Inf 0 Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0	1	1
	    1	0	2
	    1   2	0
	    ]
	    [
	    0 2 1 1
	    2 0 2 1
	    1 2 0 1
	    1 1 1 0
	    ]
	    [
	    0 1 1
	    1 0 1
	    1 1 0
	    ]
	    [
	    0 1 1 1
	    1 0 1 1
	    1 1 0 1
	    1 1 1 0
	    ]
	    };
	
	g = OrdMlBUD('B', B, 'DENSITIES', densities);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 39: OrdMlBUT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
	B11 = [
	    0   .2   .7
	    .2   0   .1
	    .7  .1   0
	    ];
	
	B22 = [    
	    0   .2   .7 .5
	    .2   0   .1 .5
	    .7  .1   0  .5
	    .5  .5  .5  0
	    ];
	B12 = rand(size(B11,1),size(B22,2));
	B21 = B12';
	B= {B11 B12;
	    B21 B22};
	
	thresholds = [0 .5 1];
	
	known_distance = {
	    [
	    0   1   1
	    1   0   1
	    1   1   0
	    ]
	    [
	    0   1   1	1
	    1   0   1   1
	    1   1   0   1
	    1   1   1   0
	    ]
	    [
	    0   Inf 1
	    Inf 0   Inf
	    1 Inf 0
	    ]
	    [
	    0 Inf 1 Inf
	    Inf 0 Inf Inf
	    1 Inf 0 Inf
	    Inf Inf Inf 0
	    ]
	    [
	    0  Inf  Inf
	    Inf  0  Inf
	    Inf  Inf  0
	    ]
	    [
	    0 Inf Inf Inf
	    Inf 0 Inf Inf
	    Inf Inf 0 Inf
	    Inf Inf Inf 0
	    ]
	    };
	
	g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds);
	
	m_outside_g = Distance('G', g);
	assert(isequal(m_outside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])
	
	m_inside_g = g.get('MEASURE', 'Distance');
	assert(isequal(m_inside_g.get('M'), known_distance), ...
	    [BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
	    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
end

%% Test 40: No Figures Left
if rand() >= (1 - 1) * BRAPH2TEST.RANDOM
	assert(isempty(findall(0, 'type', 'figure')), ...
		[BRAPH2.STR ':Distance:' BRAPH2.FAIL_TEST], ...
		[' When testing Distance no figures should be left over, either visible or not. ' ...
		int2str(length(findall(0, 'type', 'figure'))) ' figure(s) were left over.'] ...
		)
end

%% Test 41: Delete Figures
if rand() >= (1 - 1) * BRAPH2TEST.RANDOM
	delete(findall(0, 'type', 'figure'))
end

