# ./Plex\ Transcoder2 -i in.mkv -init_hw_device vulkan -vf format=yuv420p,hwupload,libplacebo=custom_shader_path=Anime4K_Clamp_Highlights.glsl,hwdownload,format=yuv420p -c:v h264_nvenc -c:a copy output.mp4

LD_LIBRARY_PATH=$(pwd) ./ffmpeg_g \
  -init_hw_device cuda=cuda:0 -filter_hw_device cuda \
  -hwaccel nvdec -hwaccel_output_format cuda \
  -i in.mkv \
  -vf format=yuv420p,hwupload=derive_device=vulkan,libplacebo=custom_shader_path=anime4k/anime4k1.glsl,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_M.glsl:w=iw*2:h=ih*2,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x2.glsl:w=iw*0.5:h=ih*0.5,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_S.glsl:w=iw*2:h=ih*2,hwupload=derive_device=cuda \
  -c:v h264_nvenc -c:a copy -loglevel verbose output.mkv

# ./Plex\ Transcoder2 \
#   -codec:0 'h264' \
#   -i in.mkv \
#   -init_hw_device vulkan \
#   -vf format=yuv420p,hwupload,libplacebo=custom_shader_path=anime4k/anime4k1.glsl,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_M.glsl:w=iw*2:h=ih*2,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x2.glsl:w=iw*0.5:h=ih*0.5,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_S.glsl:w=iw*2:h=ih*2,hwdownload \
#   -c:v h264_nvenc -c:a copy -loglevel verbose output.mkv

# libplacebo=custom_shader_path=anime4k/Anime4K_Clamp_Highlights.glsl
# ,libplacebo=custom_shader_path=anime4k/Anime4K_Restore_CNN_Soft_M.glsl
# ,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_M.glsl
# ,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x2.glsl
# ,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x4.glsl
# ,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_S.glsl

# libplacebo=custom_shader_path=anime4k/Anime4K_Clamp_Highlights.glsl,libplacebo=custom_shader_path=anime4k/Anime4K_Restore_CNN_VL.glsl,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_VL.glsl:w=iw*2:h=ih*2,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x2.glsl:w=iw*0.5:h=ih*0.5,libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x4.glsl,libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_M.glsl:w=iw*2:h=ih*2

# ~~/shaders/Anime4K_Clamp_Highlights.glsl;
# ~~/shaders/Anime4K_Restore_CNN_M.glsl;
# ~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl;
# ~~/shaders/Anime4K_AutoDownscalePre_x2.glsl;
# ~~/shaders/Anime4K_AutoDownscalePre_x4.glsl;
# ~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl

# 'hwupload',
# 'libplacebo=custom_shader_path=anime4k/anime4k1.glsl',
# 'libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_M.glsl:w=iw*2:h=ih*2',
# 'libplacebo=custom_shader_path=anime4k/Anime4K_AutoDownscalePre_x2.glsl:w=iw*0.5:h=ih*0.5',
# 'libplacebo=custom_shader_path=anime4k/Anime4K_Upscale_CNN_x2_S.glsl:w=iw*2:h=ih*2',
# 'hwdownload ',
