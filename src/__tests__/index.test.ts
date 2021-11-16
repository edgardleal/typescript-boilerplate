/**
 * IndexTest
 * Copyright (C) 2021 edgardleal
 *
 * Distributed under terms of the MIT license.
 */
import dummy from '../../index';

describe('Index', () => {
  it('should resolves to true', () => expect(dummy()).resolves.toBe(true));
});
