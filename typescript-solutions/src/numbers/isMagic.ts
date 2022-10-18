//
//  isMagic.ts
//  typescript-solutions
//
//  Created by d-exclaimation on 12:20.
//

export const isMagic = (num: number): boolean => {
  const res = [];
  let curr = num;
  let k = 0;
  while (curr > 0) {
    res.push(curr % 10);
    curr = Math.floor(curr / 10);
    k++;
  }
  return res.map(x => x ** k).reduce((acc, x) => acc + x, 0) === num;
};