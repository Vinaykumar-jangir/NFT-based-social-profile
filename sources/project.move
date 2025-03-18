module MyModule::SocialProfile {

    use aptos_framework::signer;
    use aptos_framework::vector;
    use aptos_framework::coin;

    /// Struct representing a social profile.
    struct Profile has store, key {
        name: vector<u8>,  // Profile name stored as a UTF-8 string
        creator: address,  // Creator of the profile
    }

    /// Function to create a new social profile with a name.
    public fun create_profile(owner: &signer, name: vector<u8>) {
        let profile = Profile {
            name,
            creator: signer::address_of(owner),
        };
        move_to(owner, profile);
    }

    /// Function to update the profile name.
    public fun update_name(owner: &signer, new_name: vector<u8>) acquires Profile {
        let profile = borrow_global_mut<Profile>(signer::address_of(owner));

        // Ensure the caller is the profile creator
        assert!(profile.creator == signer::address_of(owner), 1);

        // Update the profile name
        profile.name = new_name;
    }
}
