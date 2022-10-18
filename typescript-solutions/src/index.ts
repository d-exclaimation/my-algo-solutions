//
//  index.ts
//  typescript-solutions
//
//  Created by d-exclaimation on 12:14.
//

import { isMagic } from "./numbers/isMagic";


export const main = async () => {
    console.log(isMagic(153));
};

main().catch(console.log);