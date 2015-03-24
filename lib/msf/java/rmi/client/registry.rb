# -*- coding: binary -*-

module Msf
  module Java
    module Rmi
      module Client
        module Registry
          require 'msf/java/rmi/client/registry/builder'
          require 'msf/java/rmi/client/registry/parser'

          include Msf::Java::Rmi::Client::Registry::Builder
          include Msf::Java::Rmi::Client::Registry::Parser

          # Sends a Registry lookup call to the RMI endpoint
          #
          # @param opts [Hash]
          # @option opts [Rex::Socket::Tcp] :sock
          # @return [Hash, NilClass] The remote reference information if success, nil otherwise
          # @see Msf::Java::Rmi::Client::Registry::Builder.build_registry_lookup
          def send_registry_lookup(opts = {})
            send_call(
              sock: opts[:sock] || sock,
              call: build_registry_lookup(opts)
            )

            return_value = recv_return(
              sock: opts[:sock] || sock
            )

            if return_value.nil?
              return nil
            end

            if return_value.is_exception?
              raise ::Rex::Proto::Rmi::Exception, return_value.get_class_name
            end

            remote_object = return_value.get_class_name

            if remote_object.nil?
              return nil
            end

            remote_location = parse_registry_lookup_endpoint(return_value)

            if remote_location.nil?
              return nil
            end

            remote_location.merge(object: remote_object)
          end

          # Sends a Registry list call to the RMI endpoint
          #
          # @param opts [Hash]
          # @option opts [Rex::Socket::Tcp] :sock
          # @return [Array, NilClass] The set of names if success, nil otherwise
          # @see Msf::Java::Rmi::Client::Registry::Builder.build_registry_list
          def send_registry_list(opts = {})
            send_call(
              sock: opts[:sock] || sock,
              call: build_registry_list(opts)
            )

            return_value = recv_return(
              sock: opts[:sock] || sock
            )

            if return_value.nil?
              return nil
            end

            if return_value.is_exception?
              raise ::Rex::Proto::Rmi::Exception, return_value.get_class_name
            end

            names = parse_registry_list(return_value)

            names
          end
        end
      end
    end
  end
end
