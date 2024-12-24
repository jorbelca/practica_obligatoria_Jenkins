module.exports = {
  preset: "ts-jest/presets/default-esm",
  testEnvironment: "node",
  moduleNameMapper: {
    "^~/(.*)$": "<rootDir>/app/$1",
  },
  transform: {
    "^.+\\.tsx?$": "ts-jest",
  },
};
