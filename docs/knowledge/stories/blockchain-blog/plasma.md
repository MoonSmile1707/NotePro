# Plasma: Scalable Autonomous Smart Contracts

<hr/>

**Abstract**: Plasmas is a proposed framework for incentivized and enforced execution of smart contracts which is scalable to a significant amount of star updates per second (potentially billions) enabling the blockchain to be able to represent a signficant amount of decentralized financial applications worldwide. These smart contract fees, which is ultimately reliant upon the underlying blockcahin (e.g Ethereum) to enforce tracnsactional state transitions.

We propose a method for decentralized autonomous applications to scale to process not only financial activity, but also construct economic incentives for globally persisten data services which may produce an alternative to centralized server farms.

Plasma is composed of two key parts of the design: Reframing all blockchain computation into a set of MapReduce functions, and an optional method to do Prood-of-Stake token bonding on top of existiong blockchains with the understanding that the Nakamoto Consensus incentives discourage block withholding.

This construction is achieved by composing smart contracts on the main blockchain using fraud proofs whereby state transitions can be enfored on a parent blockchain. We compose blockchains into a tree hieratchy, and treat each as an individual branch blockchain with enforced blockchain history and MapReducable computation committed into merkle proofs. By framing one;ledger entry into a child blockchain which is enforced by the parent chain, one can enable incredible scale with minimized trust (presuming root blockchain availability and correctness).

The greatest complexity
around global enforcement of non-global data revolves around data availability and block withholding attacks, Plasma has mitigations for this issuw by allowing for exiting faulty chains while also creating mechanisms to incentivize and enforce continued correct execution of data.

As only merkleized commitments are broadcast periodically to the root blockchain during non-faulty states , this can allow for incredibly operating decentralized applications at high scale.

[Read Paper Here](https://plasma.io/plasma.pdf)

<hr/>

Get more information at [here](https://plasma.io/)
