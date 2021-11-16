/**
 * index.ts
 *
 * @module index.ts
 */
import Logger from './src/logger';

/**
 * A Dummy function to be tested
 */
export default async function dummy(): Promise<boolean> {
  return true;
}

(async () => {
  Logger.info('Done.');
})();
