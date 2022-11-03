<template>
    <div>
        <SignInComponent />
    </div>
</template>






<script>

import { defineComponent } from 'vue';
import SignInComponent from 'src/components/SignInComponent.vue';

export default defineComponent({
    name: 'SignInPage',

    components: {
        SignInComponent,
    },
});

</script>